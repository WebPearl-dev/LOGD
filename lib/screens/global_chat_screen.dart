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
  bool _isLoading = true;
  String _username = "Reiziger";

  @override
  void initState() {
    super.initState();
    _loadUserAndChat();
    _subscribeToChat();
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
          _messages = List<Map<String, dynamic>>.from(res);
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
              setState(() {
                _messages.add(payload.newRecord);
              });
              _scrollToBottom();
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
                      final text = msg['message'] ?? "";
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: InkWell(
                          onTap: () {
                            if (!GuestManager.isGuest) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DirectMessagesScreen(
                                    initialRecipientUsername: sender,
                                  ),
                                ),
                              );
                            }
                          },
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
