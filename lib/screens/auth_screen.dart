// lib/screens/auth_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../theme/logd_codes.dart'; // Importeer je centrale styles!
import 'town_square_screen.dart';
import 'race_selection_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  bool _isLogin = true;
  bool _isLoading = false;
  String _errorMessage = "";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final local = AppLocalizations.of(context)!;
    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final username = _usernameController.text.trim();

    if (email.isEmpty || password.isEmpty || (!_isLogin && username.isEmpty)) {
      setState(() {
        _errorMessage = "`4${local.authErrorEmpty}`w";
        _isLoading = false;
      });
      return;
    }

    try {
      if (_isLogin) {
        // --- INLOGGEN VIA SUPABASE ---
        await Supabase.instance.client.auth.signInWithPassword(
          email: email,
          password: password,
        );

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TownSquareScreen()),
        );
      } else {
        // --- REGISTREREN VIA SUPABASE ---
        final AuthResponse res = await Supabase.instance.client.auth.signUp(
          email: email,
          password: password,
          data: {'username': username},
        );

        if (res.user != null) {
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const RaceSelectionScreen()),
          );
        }
      }
    } on AuthException catch (error) {
      setState(() {
        _errorMessage = "`4${error.message}`w";
      });
    } catch (error) {
      setState(() {
        _errorMessage = "`4Er is een databasefout opgetreden.`w";
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // DE FIX: AppBar titel volledig gekoppeld aan de centrale retro-wetten!
        title: const Text(
            'LOGD',
            style: TextStyle(
                fontFamily: LogdCodes.retroFont,
                fontSize: LogdCodes.fontSizeDefault,
                fontWeight: FontWeight.bold
            )
        ),
        backgroundColor: const Color(0xFF111111),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: LogdText(
                    text: "`y== ${local.authTitle} ==`w",
                    fontSize: LogdCodes.fontSizeCardTitle,
                  ),
                ),
                const SizedBox(height: 30),

                if (_errorMessage.isNotEmpty) ...[
                  LogdText(text: _errorMessage, fontSize: LogdCodes.fontSizeDefault),
                  const SizedBox(height: 20),
                ],

                if (!_isLogin) ...[
                  TextField(
                    controller: _usernameController,
                    // DE FIX: Invoertekst, labels en borders spreken nu de centrale monospace designtaal
                    style: const TextStyle(color: Colors.white, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
                    decoration: InputDecoration(
                      labelText: local.authUsername,
                      labelStyle: const TextStyle(color: Colors.grey, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
                  decoration: InputDecoration(
                    labelText: local.authEmail,
                    labelStyle: const TextStyle(color: Colors.grey, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
                  decoration: InputDecoration(
                    labelText: local.authPassword,
                    labelStyle: const TextStyle(color: Colors.grey, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
                  ),
                ),
                const SizedBox(height: 30),

                SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.yellow, width: 2),
                      backgroundColor: const Color(0xFF1E1E00),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                    ),
                    onPressed: _isLoading ? null : _handleSubmit,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.yellow)
                        : Text(
                      (_isLogin ? local.btnLogin : local.btnRegister).toUpperCase(),
                      // DE FIX: Knoptekst font en grootte hersteld
                      style: const TextStyle(color: Colors.yellowAccent, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                      _errorMessage = "";
                    });
                  },
                  child: Text(
                    _isLogin ? local.authSwitchToRegister : local.authSwitchToLogin,
                    // DE FIX: Switch-link font en grootte hersteld naar de wet
                    style: const TextStyle(color: Colors.cyan, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
