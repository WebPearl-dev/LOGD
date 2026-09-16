// lib/screens/profile_settings_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/profile_action_panel.dart'; // Importeer je nieuwe paneel widget!
import '../theme/logd_codes.dart';
import 'auth_screen.dart';
import 'developer_panel_screen.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final _supabase = Supabase.instance.client;
  final _nameController = TextEditingController();
  final LocalAuthentication _auth = LocalAuthentication();

  bool _biometricEnabled = false;
  bool _deviceSupportsBiometrics = false;
  bool _isLoading = false;
  String _statusMessage = "";
  int _devClickCount = 0;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      final data = await _supabase.from('profiles').select().eq('id', user.id).single();
      final bool canCheck = await _auth.canCheckBiometrics;
      final bool isSupported = await _auth.isDeviceSupported();
      _deviceSupportsBiometrics = canCheck || isSupported;

      final prefs = await SharedPreferences.getInstance();
      final bool userPreference = prefs.getBool('use_biometrics') ?? false;

      if (mounted) {
        setState(() {
          _nameController.text = data['username'] ?? '';
          _biometricEnabled = _deviceSupportsBiometrics && userPreference;
        });
      }
    }
  }

  Future<void> _updateUsername() async {
    final local = AppLocalizations.of(context)!;
    setState(() { _isLoading = true; _statusMessage = ""; });
    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        await _supabase.from('profiles').update({'username': _nameController.text.trim()}).eq('id', user.id);
        setState(() { _statusMessage = local.profileSuccessUpdate; });
      }
    } catch (e) {
      setState(() { _statusMessage = "`4${local.profileDatabaseError}"; });
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  Future<void> _toggleBiometrics(bool enabled) async {
    final local = AppLocalizations.of(context)!;
    final prefs = await SharedPreferences.getInstance();

    if (enabled) {
      if (!_deviceSupportsBiometrics) {
        setState(() { _statusMessage = "`4${local.profileBiometricDeviceError}"; });
        return;
      }

      try {
        final bool didAuthenticate = await _auth.authenticate(
          localizedReason: local.profileBiometricReason, // DE FIX: Nu gelokaliseerd!
          options: const AuthenticationOptions(biometricOnly: true),
        );

        if (didAuthenticate) {
          await prefs.setBool('use_biometrics', true);
          setState(() { _biometricEnabled = true; });
        } else {
          setState(() { _biometricEnabled = false; });
        }
      } catch (e) {
        setState(() { _biometricEnabled = false; _statusMessage = "`4${local.profileBiometricAuthError}"; });
      }
    } else {
      await prefs.setBool('use_biometrics', false);
      setState(() { _biometricEnabled = false; });
    }
  }

  void _onTitleTapped() {
    _devClickCount++;
    if (_devClickCount >= 5) {
      setState(() { _devClickCount = 0; });
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DeveloperPanelScreen())).then((_) => _loadInitialData());
    }
  }

  Future<void> _logout() async {
    await _supabase.auth.signOut();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AuthScreen()), (route) => false);
  }

  void _showDeleteDialog(BuildContext ctx) {
    final local = AppLocalizations.of(ctx)!;
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF111111),
          title: Text(local.profileDeleteAccount, style: const TextStyle(fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeCardTitle, color: Colors.red, fontWeight: FontWeight.bold)),
          content: Text(local.profileDeleteWarning, style: const TextStyle(fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, color: Colors.white)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text(local.btnCancel, style: const TextStyle(fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, color: Colors.grey))),
            OutlinedButton(
              style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red, width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
              onPressed: () async {
                Navigator.pop(context);
                final user = _supabase.auth.currentUser;
                if (user != null) {
                  await _supabase.from('profiles').delete().eq('id', user.id);
                  await _logout();
                }
              },
              child: Text(local.btnSave.toUpperCase(), style: const TextStyle(fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, color: Colors.redAccent, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: GestureDetector(
          onTap: _onTitleTapped,
          child: Text(local.profileTitle, style: const TextStyle(fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold)),
        ),
        backgroundColor: const Color(0xFF2D2D2D),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_statusMessage.isNotEmpty) ...[
                LogdText(text: _statusMessage, fontSize: LogdCodes.fontSizeDefault),
                const SizedBox(height: 20),
              ],

              TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
                decoration: InputDecoration(
                  labelText: local.profileChangeName,
                  labelStyle: const TextStyle(color: Colors.grey, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
                ),
              ),
              const SizedBox(height: 20),

              Card(
                color: const Color(0xFF262626),
                child: SwitchListTile(
                  title: Text(local.profileBiometricToggle, style: const TextStyle(fontFamily: LogdCodes.retroFont, color: Colors.white, fontSize: LogdCodes.fontSizeDefault)),
                  value: _biometricEnabled,
                  activeThumbColor: Colors.cyanAccent,
                  onChanged: _toggleBiometrics,
                ),
              ),
              const SizedBox(height: 30),

              ProfileActionPanel(
                isLoading: _isLoading,
                onUpdateUsername: _updateUsername,
                onLogout: _logout,
                onDeleteAccountAttempt: _showDeleteDialog,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
