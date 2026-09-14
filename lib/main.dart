import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
      theme: ThemeData.dark(), // Zet de basis direct op dark mode

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
