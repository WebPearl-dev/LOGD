// lib/screens/global_chat_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../theme/logd_codes.dart';
import '../widgets/logd_text.dart';
import '../services/profanity_filter_service.dart';
import '../services/guest_manager.dart';
import 'direct_messages_screen.dart';

class GlobalChatScreen extends StatefulWidget {
  const GlobalChatScreen({super.key});

  @override
  State<GlobalChatScreen> createState() => _GlobalChatScreenState();
}

class _GlobalChatScreenState extends State<GlobalChatScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _messages = [];
  Set<String> _blockedUserIds = {};
  bool _isLoading = true;
  String _username = "Reiziger";

  @override
  void initState() {
    super.initState();
    _loadUserAndChat();
    _subscribeToChat();
  }

  Future<void> _loadBlockedUsers() async {
    if (GuestManager.isGuest) return;
    final user = supabase.auth.currentUser;
    if (user != null) {
      try {
        final res = await supabase.from('blocked_users').select('blocked_user_id').eq('user_id', user.id);
        _blockedUserIds = res.map((e) => e['blocked_user_id'].toString()).toSet();
      } catch (_) {}
    }
  }

  Future<void> _loadUserAndChat() async {
    if (GuestManager.isGuest) {
      _username = GuestManager.guestProfile['username'] ?? "Gast Reiziger";
    } else {
      final user = supabase.auth.currentUser;
      if (user != null) {
        final profile = await supabase.from('profiles').select('username').eq('id', user.id).maybeSingle();
        if (profile != null) {
          _username = profile['username'] ?? user.email ?? "Reiziger";
        }
      }
    }
    await _loadBlockedUsers();
    await _fetchMessages();
  }

  Future<void> _fetchMessages() async {
    try {
      final res = await supabase
          .from('global_chat')
          .select()
          .order('created_at', ascending: true)
          .limit(50);
      if (mounted) {
        setState(() {
          _messages = List<Map<String, dynamic>>.from(res).where((m) {
            final senderId = m['sender_id']?.toString();
            return senderId == null || !_blockedUserIds.contains(senderId);
          }).toList();
          _isLoading = false;
        });
        _scrollToBottom();
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _subscribeToChat() {
    supabase
        .channel('public:global_chat')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'global_chat',
          callback: (payload) {
            if (mounted) {
              final senderId = payload.newRecord['sender_id']?.toString();
              if (senderId == null || !_blockedUserIds.contains(senderId)) {
                setState(() {
                  _messages.add(payload.newRecord);
                });
                _scrollToBottom();
              }
            }
          },
        )
        .subscribe();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final cleanedText = ProfanityFilterService.clean(text);
    _messageController.clear();

    if (GuestManager.isGuest) {
      setState(() {
        _messages.add({
          'sender_username': _username,
          'message': cleanedText,
          'created_at': DateTime.now().toIso8601String(),
        });
      });
      _scrollToBottom();
      return;
    }

    final user = supabase.auth.currentUser;
    if (user != null) {
      try {
        await supabase.from('global_chat').insert({
          'sender_id': user.id,
          'sender_username': _username,
          'message': cleanedText,
        });
      } catch (_) {}
    }
  }

  void _showUserOptionsDialog(String? senderId, String senderUsername) {
    if (GuestManager.isGuest || senderId == null) {
      if (!GuestManager.isGuest) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DirectMessagesScreen(
              initialRecipientUsername: senderUsername,
            ),
          ),
        );
      }
      return;
    }
    final local = AppLocalizations.of(context)!;
    final currentContext = context;

    showModalBottomSheet(
      context: currentContext,
      backgroundColor: LogdCodes.uiCardBg,
      builder: (sheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.message, color: LogdCodes.uiGreen),
                title: Text(local.directMessagesTitle, style: const TextStyle(color: Colors.white, fontFamily: LogdCodes.retroFont)),
                onTap: () {
                  Navigator.pop(sheetContext);
                  if (currentContext.mounted) {
                    Navigator.push(
                      currentContext,
                      MaterialPageRoute(
                        builder: (context) => DirectMessagesScreen(
                          initialRecipientUsername: senderUsername,
                        ),
                      ),
                    );
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.report, color: Colors.orange),
                title: Text(local.reportUser, style: const TextStyle(color: Colors.white, fontFamily: LogdCodes.retroFont)),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showReportDialog(senderId, senderUsername);
                },
              ),
              ListTile(
                leading: const Icon(Icons.block, color: Colors.red),
                title: Text(local.blockUser, style: const TextStyle(color: Colors.white, fontFamily: LogdCodes.retroFont)),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _blockUser(senderId, senderUsername);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showReportDialog(String userId, String username) {
    final local = AppLocalizations.of(context)!;
    final TextEditingController reasonController = TextEditingController();
    final currentContext = context;

    showDialog(
      context: currentContext,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: LogdCodes.uiCardBg,
        title: Text("${local.reportUser}: $username", style: const TextStyle(color: LogdCodes.uiYellow, fontFamily: LogdCodes.retroFont)),
        content: TextField(
          controller: reasonController,
          style: const TextStyle(color: Colors.white, fontFamily: LogdCodes.retroFont),
          decoration: InputDecoration(
            hintText: local.reportReasonPrompt,
            hintStyle: TextStyle(color: Colors.grey.withValues(alpha: 0.7), fontFamily: LogdCodes.retroFont),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(local.btnCancel, style: const TextStyle(fontFamily: LogdCodes.retroFont)),
          ),
          TextButton(
            onPressed: () async {
              final reason = reasonController.text.trim();
              if (reason.isNotEmpty) {
                final user = supabase.auth.currentUser;
                if (user != null) {
                  try {
                    await supabase.from('reports').insert({
                      'reporter_id': user.id,
                      'reported_user_id': userId,
                      'reason': reason,
                    });
                    if (currentContext.mounted) {
                      ScaffoldMessenger.of(currentContext).showSnackBar(
                        SnackBar(content: Text(local.reportSuccess, style: const TextStyle(fontFamily: LogdCodes.retroFont))),
                      );
                    }
                  } catch (_) {}
                }
              }
              if (dialogContext.mounted) {
                Navigator.pop(dialogContext);
              }
            },
            child: Text(local.btnSend, style: const TextStyle(color: LogdCodes.uiGreen, fontFamily: LogdCodes.retroFont)),
          ),
        ],
      ),
    );
  }

  Future<void> _blockUser(String userId, String username) async {
    final local = AppLocalizations.of(context)!;
    final user = supabase.auth.currentUser;
    if (user != null) {
      try {
        await supabase.from('blocked_users').insert({
          'user_id': user.id,
          'blocked_user_id': userId,
        });
        if (!mounted) return;
        setState(() {
          _blockedUserIds.add(userId);
          _messages.removeWhere((m) => m['sender_id'] == userId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(local.blockSuccess, style: const TextStyle(fontFamily: LogdCodes.retroFont))),
        );
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: LogdCodes.uiBlueBg,
      appBar: AppBar(
        title: Text(
          local.globalChatTitle.toUpperCase(),
          style: const TextStyle(
            fontFamily: LogdCodes.retroFont,
            fontSize: LogdCodes.fontSizeCardTitle,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: LogdCodes.uiAppBarBg,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: LogdCodes.uiGreen))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      final sender = msg['sender_username'] ?? local.defaultUsername;
                      final senderId = msg['sender_id']?.toString();
                      final text = msg['message'] ?? "";
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: InkWell(
                          onTap: () => _showUserOptionsDialog(senderId, sender),
                          onLongPress: () => _showUserOptionsDialog(senderId, sender),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: LogdCodes.uiCardBg,
                              border: Border.all(color: Colors.cyan.withValues(alpha: 0.3)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "[$sender]:",
                                  style: const TextStyle(
                                    color: LogdCodes.uiYellow,
                                    fontFamily: LogdCodes.retroFont,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                LogdText(
                                  text: text,
                                  fontSize: LogdCodes.fontSizeDefault - 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: LogdCodes.uiAppBarBg,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: LogdCodes.retroFont,
                          ),
                          decoration: InputDecoration(
                            hintText: local.chatSendHint,
                            hintStyle: TextStyle(
                              color: Colors.grey.withValues(alpha: 0.7),
                              fontFamily: LogdCodes.retroFont,
                              fontSize: 12,
                            ),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: LogdCodes.uiGreen),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
