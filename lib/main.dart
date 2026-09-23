import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'l10n/app_localizations.dart';
import 'screens/auth_screen.dart';
import 'screens/graveyard_screen.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://wubnlnermijpgfrgkdyz.supabase.co',
    publishableKey: 'sb_publishable_ycTo3nyRh04Gx4NBZ4XtDA_gflZkqwA',
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? langCode = prefs.getString('language_code');
    if (langCode != null && mounted) {
      setState(() {
        _locale = Locale(langCode);
      });
    }
  }

  void setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      title: 'Legend of the Golden Dragon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        fontFamily: 'monospace',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'monospace', fontSize: 17.0, color: Colors.white),
          bodyMedium: TextStyle(fontFamily: 'monospace', fontSize: 17.0, color: Colors.white),
          titleLarge: TextStyle(fontFamily: 'monospace', fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontFamily: 'monospace', fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            textStyle: const TextStyle(fontFamily: 'monospace', fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('nl'),
        Locale('en'),
      ],
      home: const SplashScreen(),

      // DE LIVE BEVEILIGINGS-GUARD: Volledig herschreven naar een veilige Future-opzet!
      builder: (context, child) {
        return StreamBuilder<AuthState>(
          stream: Supabase.instance.client.auth.onAuthStateChange,
          builder: (context, authSnapshot) {
            final session = authSnapshot.data?.session;
            if (session == null) return child ?? const AuthScreen();

            // FIX: We gebruiken een StreamBuilder om realtime wijzigingen in het spelersprofiel te volgen (zoals herrijzen)
            return StreamBuilder<List<Map<String, dynamic>>>(
              stream: Supabase.instance.client
                  .from('profiles')
                  .stream(primaryKey: ['id'])
                  .eq('id', session.user.id),
              builder: (context, profileSnapshot) {
                if (profileSnapshot.connectionState == ConnectionState.waiting) {
                  return child ?? const AuthScreen();
                }

                final profileData = profileSnapshot.data?.firstOrNull;
                final bool isAlive = profileData?['alive'] ?? true;

                // Als de speler dood is, blokkeer de app en toon de Begraafplaats in een eigen Navigator
                // Hierdoor kan de Begraafplaats zelf weer schermen (zoals GhostCombat) pushen.
                if (!isAlive) {
                  return Navigator(
                    onGenerateRoute: (settings) => MaterialPageRoute(
                      builder: (context) => const GraveyardScreen(),
                    ),
                  );
                }

                return child ?? const AuthScreen();
              },
            );
          },
        );
      },
    );
  }
}
