// lib/screens/direct_messages_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../theme/logd_codes.dart';
import '../widgets/logd_text.dart';
import '../services/profanity_filter_service.dart';
import '../services/guest_manager.dart';

class DirectMessagesScreen extends StatefulWidget {
  final String? initialRecipientUsername;

  const DirectMessagesScreen({super.key, this.initialRecipientUsername});

  @override
  State<DirectMessagesScreen> createState() => _DirectMessagesScreenState();
}

class _DirectMessagesScreenState extends State<DirectMessagesScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> _conversations = [];
  List<Map<String, dynamic>> _messages = [];
  List<Map<String, dynamic>> _allProfiles = [];
  
  String? _selectedRecipientId;
  String? _selectedRecipientUsername;
  bool _isLoading = true;
  String _currentUserId = "";
  String _currentUsername = "Reiziger";

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    if (GuestManager.isGuest) {
      setState(() => _isLoading = false);
      return;
    }

    final user = supabase.auth.currentUser;
    if (user != null) {
      _currentUserId = user.id;
      final profile = await supabase.from('profiles').select('username').eq('id', user.id).maybeSingle();
      if (profile != null) {
        _currentUsername = profile['username'] ?? user.email ?? "Reiziger";
      }

      // Load all profiles for starting new DMs
      final profilesRes = await supabase.from('profiles').select('id, username').not('id', 'eq', _currentUserId);
      _allProfiles = List<Map<String, dynamic>>.from(profilesRes);

      if (widget.initialRecipientUsername != null) {
        final match = _allProfiles.firstWhere(
          (p) => p['username'] == widget.initialRecipientUsername,
          orElse: () => {},
        );
        if (match.isNotEmpty) {
          _selectedRecipientId = match['id'];
          _selectedRecipientUsername = match['username'];
          await _loadMessagesWith(_selectedRecipientId!);
        }
      } else {
        await _loadConversations();
      }
    }
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _loadConversations() async {
    try {
      final res = await supabase
          .from('direct_messages')
          .select()
          .or('sender_id.eq.$_currentUserId,receiver_id.eq.$_currentUserId')
          .order('created_at', ascending: false);

      final List<Map<String, dynamic>> raw = List<Map<String, dynamic>>.from(res);
      Map<String, Map<String, dynamic>> convMap = {};
      for (final m in raw) {
        final senderId = m['sender_id'];
        final receiverId = m['receiver_id'];
        final otherId = senderId == _currentUserId ? receiverId : senderId;
        final otherUsername = senderId == _currentUserId ? m['receiver_username'] : m['sender_username'];

        if (!convMap.containsKey(otherId)) {
          convMap[otherId] = {
            'user_id': otherId,
            'username': otherUsername,
            'last_message': m['message'],
            'created_at': m['created_at'],
          };
        }
      }
      setState(() {
        _conversations = convMap.values.toList();
      });
    } catch (_) {}
  }

  Future<void> _loadMessagesWith(String recipientId) async {
    try {
      final res = await supabase
          .from('direct_messages')
          .select()
          .or('and(sender_id.eq.$_currentUserId,receiver_id.eq.$recipientId),and(sender_id.eq.$recipientId,receiver_id.eq.$_currentUserId)')
          .order('created_at', ascending: true);

      setState(() {
        _messages = List<Map<String, dynamic>>.from(res);
      });
    } catch (_) {}
  }

  void _sendDm() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _selectedRecipientId == null || _selectedRecipientUsername == null) return;

    final cleaned = ProfanityFilterService.clean(text);
    _messageController.clear();

    try {
      await supabase.from('direct_messages').insert({
        'sender_id': _currentUserId,
        'receiver_id': _selectedRecipientId,
        'sender_username': _currentUsername,
        'receiver_username': _selectedRecipientUsername,
        'message': cleaned,
      });
      await _loadMessagesWith(_selectedRecipientId!);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (GuestManager.isGuest) {
      return Scaffold(
        backgroundColor: LogdCodes.uiBlueBg,
        appBar: AppBar(title: Text(local.directMessagesTitle.toUpperCase(), style: const TextStyle(fontFamily: LogdCodes.retroFont))),
        body: Center(child: LogdText(text: local.dmNoConversations)),
      );
    }

    return Scaffold(
      backgroundColor: LogdCodes.uiBlueBg,
      appBar: AppBar(
        title: Text(
          _selectedRecipientUsername != null
              ? "DM: $_selectedRecipientUsername"
              : local.directMessagesTitle.toUpperCase(),
          style: const TextStyle(
            fontFamily: LogdCodes.retroFont,
            fontSize: LogdCodes.fontSizeCardTitle,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: LogdCodes.uiAppBarBg,
        actions: [
          if (_selectedRecipientId != null)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                setState(() {
                  _selectedRecipientId = null;
                  _selectedRecipientUsername = null;
                  _messages.clear();
                });
                _loadConversations();
              },
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: LogdCodes.uiGreen))
          : _selectedRecipientId == null
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        dropdownColor: LogdCodes.uiCardBg,
                        style: const TextStyle(color: Colors.white, fontFamily: LogdCodes.retroFont),
                        decoration: InputDecoration(
                          labelText: local.dmSelectRecipient,
                          labelStyle: const TextStyle(color: LogdCodes.uiYellow, fontFamily: LogdCodes.retroFont),
                          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: LogdCodes.uiBlueDark)),
                          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: LogdCodes.uiGreen)),
                        ),
                        items: _allProfiles.map((p) {
                          return DropdownMenuItem<String>(
                            value: p['id'].toString(),
                            child: Text(p['username'] ?? 'Reiziger', style: const TextStyle(fontFamily: LogdCodes.retroFont)),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            final match = _allProfiles.firstWhere((p) => p['id'].toString() == val);
                            setState(() {
                              _selectedRecipientId = match['id'];
                              _selectedRecipientUsername = match['username'];
                            });
                            _loadMessagesWith(_selectedRecipientId!);
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: _conversations.isEmpty
                          ? Center(child: Padding(padding: const EdgeInsets.all(16.0), child: LogdText(text: local.dmNoConversations)))
                          : ListView.builder(
                              itemCount: _conversations.length,
                              itemBuilder: (context, index) {
                                final conv = _conversations[index];
                                return ListTile(
                                  title: Text(
                                    conv['username'] ?? 'Reiziger',
                                    style: const TextStyle(color: LogdCodes.uiYellow, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    conv['last_message'] ?? '',
                                    style: const TextStyle(color: Colors.grey, fontFamily: LogdCodes.retroFont),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _selectedRecipientId = conv['user_id'];
                                      _selectedRecipientUsername = conv['username'];
                                    });
                                    _loadMessagesWith(_selectedRecipientId!);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final msg = _messages[index];
                          final isMe = msg['sender_id'] == _currentUserId;
                          return Align(
                            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isMe ? LogdCodes.uiGreenBg : LogdCodes.uiCardBg,
                                border: Border.all(color: isMe ? LogdCodes.uiGreen : LogdCodes.uiBlueDark),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    msg['sender_username'] ?? '',
                                    style: TextStyle(
                                      color: isMe ? LogdCodes.uiGreen : LogdCodes.uiYellow,
                                      fontFamily: LogdCodes.retroFont,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  LogdText(
                                    text: msg['message'] ?? '',
                                    fontSize: LogdCodes.fontSizeDefault - 1,
                                  ),
                                ],
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
                              style: const TextStyle(color: Colors.white, fontFamily: LogdCodes.retroFont),
                              decoration: InputDecoration(
                                hintText: local.chatSendHint,
                                hintStyle: TextStyle(color: Colors.grey.withValues(alpha: 0.7), fontFamily: LogdCodes.retroFont, fontSize: 12),
                                border: InputBorder.none,
                              ),
                              onSubmitted: (_) => _sendDm(),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send, color: LogdCodes.uiGreen),
                            onPressed: _sendDm,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
