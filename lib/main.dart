// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // DE FIX: Extensie weer kaarsrecht naar .dart!
import 'l10n/app_localizations.dart';
import 'screens/auth_screen.dart';

void main() async {
  // Zorgt ervoor dat Flutter goed opstart voordat de database laadt
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiseer Supabase met jouw unieke projectgegevens
  await Supabase.initialize(
    url: 'https://wubnlnermijpgfrgkdyz.supabase.co',
    publishableKey: 'sb_publishable_ycTo3nyRh04Gx4NBZ4XtDA_gflZkqwA',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lord of the Golden Dragon',
      debugShowCheckedModeBanner: false,

      // De globale retro-wet: Custom dark theme dat de monospace-letter
      // dwingend oplegt aan álle tekst, titels en knoppen!
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),

        // Zorgt dat elk tekstloos element standaard naar monospace grijpt
        fontFamily: 'monospace',

        // Dit herstructureert alle tekststijlen binnen schermen en kaarten
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'monospace', fontSize: 17.0, color: Colors.white),
          bodyMedium: TextStyle(fontFamily: 'monospace', fontSize: 17.0, color: Colors.white),
          titleLarge: TextStyle(fontFamily: 'monospace', fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),

        // DE FIX VOOR DE BUTTONS: Zorgt dat álle grid- en actieknoppen direct de retro-letter pakken!
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
        Locale('nl'), // Nederlands
        Locale('en'), // Engels
      ],

      // De app start nu veilig op bij de toegangspoort van het rijk
      home: const AuthScreen(),
    );
  }
}
