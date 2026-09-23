// lib/screens/profile_settings_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../theme/logd_codes.dart';
import '../main.dart';
import 'auth_screen.dart';
import 'developer_panel_screen.dart';
import '../services/guest_manager.dart';
import '../widgets/logd_tutorial_dialog.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final _supabase = Supabase.instance.client;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _feedbackController = TextEditingController();
  final LocalAuthentication _auth = LocalAuthentication();

  bool _biometricEnabled = false;
  bool _deviceSupportsBiometrics = false;
  bool _isLoading = false;
  String _statusMessage = "";
  int _devClickCount = 0;
  Map<String, dynamic>? _profileData;

  bool _isAccountExpanded = true;
  bool _isLanguageExpanded = false;
  bool _isCommunityExpanded = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      final data = await _supabase.from('profiles').select().eq('id', user.id).maybeSingle();
      final bool canCheck = await _auth.canCheckBiometrics;
      final bool isSupported = await _auth.isDeviceSupported();
      _deviceSupportsBiometrics = canCheck || isSupported;

      final prefs = await SharedPreferences.getInstance();
      final bool userPreference = prefs.getBool('use_biometrics') ?? false;

      if (mounted) {
        setState(() {
          _profileData = data;
          _nameController.text = data?['username'] ?? '';
          _emailController.text = user.email ?? '';
          _biometricEnabled = _deviceSupportsBiometrics && userPreference;
        });
      }
    } else if (GuestManager.isGuest) {
      _nameController.text = GuestManager.guestProfile['username'] ?? '';
    }
  }

  Future<void> _updateUsername() async {
    final local = AppLocalizations.of(context)!;
    final newName = _nameController.text.trim();
    if (newName.isEmpty) return;

    setState(() { _isLoading = true; _statusMessage = ""; });
    try {
      if (GuestManager.isGuest) {
        GuestManager.guestProfile['username'] = newName;
        setState(() { _statusMessage = local.profileSuccessUpdate; });
      } else {
        final user = _supabase.auth.currentUser;
        if (user != null) {
          await _supabase.from('profiles').update({'username': newName}).eq('id', user.id);
          setState(() { _statusMessage = local.profileSuccessUpdate; });
        }
      }
    } catch (e) {
      setState(() { _statusMessage = "`4${local.profileDatabaseError}`w"; });
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  Future<void> _updateEmail() async {
    final local = AppLocalizations.of(context)!;
    setState(() { _isLoading = true; _statusMessage = ""; });
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return;
      final newEmail = _emailController.text.trim();
      if (newEmail.isEmpty) {
        setState(() { _statusMessage = "`4${local.profileEmailError}`w"; });
        return;
      }

      bool rpcSuccess = false;
      try {
        await _supabase.rpc('update_user_email', params: {'new_email': newEmail});
        rpcSuccess = true;
      } catch (_) {}

      if (!rpcSuccess) {
        final res = await _supabase.auth.updateUser(UserAttributes(email: newEmail));
        if (res.user?.newEmail != null) {
          setState(() { _statusMessage = "`2${local.profileEmailSuccessUpdate}\n(Bevestiging verstuurd naar nieuw e-mailadres)`w"; });
          return;
        }
      }

      try {
        await _supabase.from('profiles').update({'email': newEmail}).eq('id', user.id);
      } catch (_) {}

      setState(() { _statusMessage = "`2${local.profileEmailSuccessUpdate}`w"; });
    } on AuthException catch (e) {
      setState(() { _statusMessage = "`4${e.message}`w"; });
    } catch (e) {
      setState(() { _statusMessage = "`4$e`w"; });
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  Future<void> _updatePassword() async {
    final local = AppLocalizations.of(context)!;
    final newPassword = _passwordController.text.trim();
    if (newPassword.isEmpty) {
      setState(() { _statusMessage = local.profilePasswordErrorEmpty; });
      return;
    }

    setState(() { _isLoading = true; _statusMessage = ""; });
    try {
      await _supabase.auth.updateUser(UserAttributes(password: newPassword));
      _passwordController.clear();
      setState(() { _statusMessage = local.profilePasswordSuccessUpdate; });
    } on AuthException catch (e) {
      setState(() { _statusMessage = "`4${e.message}`w"; });
    } catch (e) {
      setState(() { _statusMessage = local.profilePasswordError; });
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  Future<void> _toggleBiometrics(bool enabled) async {
    final local = AppLocalizations.of(context)!;
    final prefs = await SharedPreferences.getInstance();

    if (enabled) {
      if (!_deviceSupportsBiometrics) {
        setState(() { _statusMessage = "`4${local.profileBiometricDeviceError}`w"; });
        return;
      }

      try {
        final bool didAuthenticate = await _auth.authenticate(
          localizedReason: local.profileBiometricReason,
          options: const AuthenticationOptions(biometricOnly: true),
        );

        if (didAuthenticate) {
          await prefs.setBool('use_biometrics', true);
          setState(() { _biometricEnabled = true; });
        } else {
          setState(() { _biometricEnabled = false; });
        }
      } catch (e) {
        setState(() { _biometricEnabled = false; _statusMessage = "`4${local.profileBiometricAuthError}`w"; });
      }
    } else {
      await prefs.setBool('use_biometrics', false);
      setState(() { _biometricEnabled = false; });
    }
  }

  void _onTitleTapped() {
    final user = _supabase.auth.currentUser;
    final bool isAdmin = _profileData?['is_admin'] == true || user?.email == 'samhaoir@live.nl';
    if (GuestManager.isGuest || !isAdmin) {
      return;
    }
    _devClickCount++;
    if (_devClickCount >= 5) {
      setState(() { _devClickCount = 0; });
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DeveloperPanelScreen())).then((_) => _loadInitialData());
    }
  }

  Future<void> _logout() async {
    if (GuestManager.isGuest) {
      GuestManager.isGuest = false;
    } else {
      await _supabase.auth.signOut();
    }
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AuthScreen()), (route) => false);
  }

  void _showDeleteDialog(BuildContext ctx) {
    final local = AppLocalizations.of(ctx)!;
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: LogdCodes.uiCardBg,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: LogdCodes.uiRed, width: 1.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Text(
            local.profileDeleteAccount,
            style: const TextStyle(
              fontFamily: LogdCodes.retroFont,
              fontSize: LogdCodes.fontSizeCardTitle,
              color: LogdCodes.uiRed,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            local.profileDeleteWarning,
            style: const TextStyle(
              fontFamily: LogdCodes.retroFont,
              fontSize: LogdCodes.fontSizeDefault,
              color: Colors.white,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                local.btnCancel,
                style: const TextStyle(
                  fontFamily: LogdCodes.retroFont,
                  fontSize: LogdCodes.fontSizeDefault,
                  color: LogdCodes.uiGrey,
                ),
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: LogdCodes.uiRed, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              ),
              onPressed: () async {
                Navigator.pop(context);
                final user = _supabase.auth.currentUser;
                if (user != null) {
                  await _supabase.from('profiles').delete().eq('id', user.id);
                  await _logout();
                } else if (GuestManager.isGuest) {
                  await _logout();
                }
              },
              child: Text(
                local.profileDeleteAccount.toUpperCase(),
                style: const TextStyle(
                  fontFamily: LogdCodes.retroFont,
                  fontSize: LogdCodes.fontSizeDefault,
                  color: LogdCodes.uiRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showRetroDialog({
    required String title,
    required String textContent,
    Color titleColor = LogdCodes.uiCyan,
    Widget? extraContent,
    List<Widget>? customActions,
  }) {
    final local = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: LogdCodes.uiCardBg,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: titleColor, width: 1.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontFamily: LogdCodes.retroFont,
              fontSize: LogdCodes.fontSizeCardTitle,
              color: titleColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LogdText(text: textContent, fontSize: LogdCodes.fontSizeDefault),
                if (extraContent != null) ...[
                  const SizedBox(height: 16),
                  extraContent,
                ],
              ],
            ),
          ),
          actions: customActions ?? [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: titleColor, width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(
                local.btnClose,
                style: TextStyle(
                  fontFamily: LogdCodes.retroFont,
                  fontSize: LogdCodes.fontSizeDefault,
                  color: titleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showFeedbackDialog() {
    final local = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: LogdCodes.uiCardBg,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: LogdCodes.uiCyan, width: 1.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Text(
            local.settingsFeedbackDialogTitle.toUpperCase(),
            style: const TextStyle(
              fontFamily: LogdCodes.retroFont,
              fontSize: LogdCodes.fontSizeCardTitle,
              color: LogdCodes.uiCyan,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LogdText(text: local.settingsFeedbackDialogText, fontSize: LogdCodes.fontSizeDefault),
                const SizedBox(height: 16),
                TextField(
                  controller: _feedbackController,
                  maxLines: 4,
                  style: const TextStyle(color: Colors.white, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
                  decoration: InputDecoration(
                    hintText: local.settingsFeedbackHint,
                    hintStyle: const TextStyle(color: LogdCodes.uiGrey, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: LogdCodes.uiGrey)),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: LogdCodes.uiCyan)),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                local.btnCancel,
                style: const TextStyle(fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, color: LogdCodes.uiGrey),
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: LogdCodes.uiCyan, width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              ),
              onPressed: () {
                _feedbackController.clear();
                Navigator.pop(context);
                setState(() {
                  _statusMessage = local.settingsFeedbackSent;
                });
              },
              child: Text(
                local.settingsBtnSend,
                style: const TextStyle(
                  fontFamily: LogdCodes.retroFont,
                  fontSize: LogdCodes.fontSizeDefault,
                  color: LogdCodes.uiCyan,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildExpandableSectionCard({
    required String title,
    required Color titleColor,
    required bool isExpanded,
    required VoidCallback onToggle,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: LogdCodes.uiCardBg,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: titleColor.withValues(alpha: isExpanded ? 0.6 : 0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(width: 4, height: 18, color: titleColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        fontFamily: LogdCodes.retroFont,
                        fontSize: LogdCodes.fontSizeCardTitle,
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: titleColor,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            Divider(height: 1, color: titleColor.withValues(alpha: 0.2)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCommunityTile({
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: LogdCodes.retroFont,
            fontSize: LogdCodes.fontSizeDefault,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontFamily: LogdCodes.retroFont,
            fontSize: 13.0,
            color: LogdCodes.uiGrey,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: color),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final user = _supabase.auth.currentUser;
    final bool isAccountUser = !GuestManager.isGuest && user != null;
    final String currentLang = Localizations.localeOf(context).languageCode;

    return Scaffold(
      backgroundColor: LogdCodes.uiBlueBg,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: GestureDetector(
          onTap: _onTitleTapped,
          child: Text(
            local.profileTitle,
            style: const TextStyle(
              fontFamily: LogdCodes.retroFont,
              fontSize: LogdCodes.fontSizeDefault,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: LogdCodes.uiAppBarBg,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_statusMessage.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: LogdCodes.uiCardBg,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: LogdCodes.uiYellow, width: 1.0),
                  ),
                  child: LogdText(text: _statusMessage, fontSize: LogdCodes.fontSizeDefault),
                ),
                const SizedBox(height: 20),
              ],

              // SECTION 1: Karakters & Account
              _buildExpandableSectionCard(
                title: local.settingsSectionAccount,
                titleColor: LogdCodes.uiYellow,
                isExpanded: _isAccountExpanded,
                onToggle: () => setState(() => _isAccountExpanded = !_isAccountExpanded),
                children: [
                  // Karakternaam
                  TextField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.white, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
                    decoration: InputDecoration(
                      labelText: local.profileChangeName,
                      labelStyle: const TextStyle(color: LogdCodes.uiGrey, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: LogdCodes.uiGrey)),
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: LogdCodes.uiYellow)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: LogdCodes.uiYellow, width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                      ),
                      onPressed: _isLoading ? null : _updateUsername,
                      child: Text(
                        local.profileSaveName.toUpperCase(),
                        style: const TextStyle(color: LogdCodes.uiYellow, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (isAccountUser) ...[
                    // E-mailadres
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
                      decoration: InputDecoration(
                        labelText: local.profileChangeEmail,
                        labelStyle: const TextStyle(color: LogdCodes.uiGrey, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: LogdCodes.uiGrey)),
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: LogdCodes.uiYellow)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: LogdCodes.uiCyan, width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                        ),
                        onPressed: _isLoading ? null : _updateEmail,
                        child: Text(
                          local.profileSaveEmail.toUpperCase(),
                          style: const TextStyle(color: LogdCodes.uiCyan, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Wachtwoord Wijzigen
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
                      decoration: InputDecoration(
                        labelText: local.profileChangePassword,
                        labelStyle: const TextStyle(color: LogdCodes.uiGrey, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: LogdCodes.uiGrey)),
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: LogdCodes.uiYellow)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: LogdCodes.uiGreen, width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                        ),
                        onPressed: _isLoading ? null : _updatePassword,
                        child: Text(
                          local.profileSavePassword.toUpperCase(),
                          style: const TextStyle(color: LogdCodes.uiGreen, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Biometrisch
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(color: LogdCodes.uiGrey.withValues(alpha: 0.3)),
                      ),
                      child: SwitchListTile(
                        title: Text(
                          local.profileBiometricToggle,
                          style: const TextStyle(fontFamily: LogdCodes.retroFont, color: Colors.white, fontSize: LogdCodes.fontSizeDefault),
                        ),
                        value: _biometricEnabled,
                        activeThumbColor: LogdCodes.uiCyan,
                        onChanged: _toggleBiometrics,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Actieknoppen: Uitloggen & Account Verwijderen
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: LogdCodes.uiCyan, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                    ),
                    onPressed: _isLoading ? null : _logout,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        local.profileLogout.toUpperCase(),
                        style: const TextStyle(color: LogdCodes.uiCyan, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: LogdCodes.uiRed, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                    ),
                    onPressed: _isLoading ? null : () => _showDeleteDialog(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        local.profileDeleteAccount.toUpperCase(),
                        style: const TextStyle(color: LogdCodes.uiRed, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),

              // SECTION 2: Taal & Voorkeuren
              _buildExpandableSectionCard(
                title: local.settingsSectionLanguage,
                titleColor: LogdCodes.uiCyan,
                isExpanded: _isLanguageExpanded,
                onToggle: () => setState(() => _isLanguageExpanded = !_isLanguageExpanded),
                children: [
                  Text(
                    local.settingsLanguageTitle,
                    style: const TextStyle(
                      fontFamily: LogdCodes.retroFont,
                      fontSize: LogdCodes.fontSizeDefault,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: currentLang == 'nl' ? LogdCodes.uiCyan : LogdCodes.uiGrey,
                              width: currentLang == 'nl' ? 2.0 : 1.0,
                            ),
                            backgroundColor: currentLang == 'nl' ? LogdCodes.uiCyan.withValues(alpha: 0.15) : Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () => MyApp.setLocale(context, const Locale('nl')),
                          child: Text(
                            local.settingsLangDutch,
                            style: TextStyle(
                              fontFamily: LogdCodes.retroFont,
                              fontSize: LogdCodes.fontSizeDefault,
                              color: currentLang == 'nl' ? LogdCodes.uiCyan : LogdCodes.uiGrey,
                              fontWeight: currentLang == 'nl' ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: currentLang == 'en' ? LogdCodes.uiCyan : LogdCodes.uiGrey,
                              width: currentLang == 'en' ? 2.0 : 1.0,
                            ),
                            backgroundColor: currentLang == 'en' ? LogdCodes.uiCyan.withValues(alpha: 0.15) : Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () => MyApp.setLocale(context, const Locale('en')),
                          child: Text(
                            local.settingsLangEnglish,
                            style: TextStyle(
                              fontFamily: LogdCodes.retroFont,
                              fontSize: LogdCodes.fontSizeDefault,
                              color: currentLang == 'en' ? LogdCodes.uiCyan : LogdCodes.uiGrey,
                              fontWeight: currentLang == 'en' ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // SECTION 3: Over LOGD & Community
              _buildExpandableSectionCard(
                title: local.settingsSectionCommunity,
                titleColor: LogdCodes.uiGreen,
                isExpanded: _isCommunityExpanded,
                onToggle: () => setState(() => _isCommunityExpanded = !_isCommunityExpanded),
                children: [
                  _buildCommunityTile(
                    title: local.settingsTutorialTitle,
                    subtitle: local.settingsTutorialSubtitle,
                    color: LogdCodes.uiCyan,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const LogdTutorialDialog(),
                      );
                    },
                  ),
                  _buildCommunityTile(
                    title: local.settingsAboutTitle,
                    subtitle: local.settingsAboutSubtitle,
                    color: LogdCodes.uiGreen,
                    onTap: () => _showRetroDialog(
                      title: local.settingsAboutTitle,
                      textContent: local.settingsAboutStory,
                      titleColor: LogdCodes.uiGreen,
                    ),
                  ),
                  _buildCommunityTile(
                    title: local.settingsShareTitle,
                    subtitle: local.settingsShareSubtitle,
                    color: LogdCodes.uiYellow,
                    onTap: () => _showRetroDialog(
                      title: local.settingsShareDialogTitle,
                      textContent: local.settingsShareDialogText,
                      titleColor: LogdCodes.uiYellow,
                      customActions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(local.btnClose, style: const TextStyle(fontFamily: LogdCodes.retroFont, color: LogdCodes.uiGrey)),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: LogdCodes.uiYellow, width: 1.5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            local.settingsBtnShare,
                            style: const TextStyle(fontFamily: LogdCodes.retroFont, color: LogdCodes.uiYellow, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildCommunityTile(
                    title: local.settingsRateTitle,
                    subtitle: local.settingsRateSubtitle,
                    color: LogdCodes.uiYellow,
                    onTap: () => _showRetroDialog(
                      title: local.settingsRateDialogTitle,
                      textContent: local.settingsRateDialogText,
                      titleColor: LogdCodes.uiYellow,
                      customActions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(local.btnClose, style: const TextStyle(fontFamily: LogdCodes.retroFont, color: LogdCodes.uiGrey)),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: LogdCodes.uiYellow, width: 1.5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            local.settingsBtnRate,
                            style: const TextStyle(fontFamily: LogdCodes.retroFont, color: LogdCodes.uiYellow, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildCommunityTile(
                    title: local.settingsFeedbackTitle,
                    subtitle: local.settingsFeedbackSubtitle,
                    color: LogdCodes.uiCyan,
                    onTap: _showFeedbackDialog,
                  ),
                  _buildCommunityTile(
                    title: local.settingsPrivacyTitle,
                    subtitle: local.settingsPrivacySubtitle,
                    color: LogdCodes.uiPurple,
                    onTap: () => _showRetroDialog(
                      title: local.settingsPrivacyDialogTitle,
                      textContent: local.settingsPrivacyDialogText,
                      titleColor: LogdCodes.uiPurple,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
