// lib/screens/splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/logd_codes.dart';
import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Toon de splash voor 3 seconden
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AuthScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LogdCodes.uiBlueBg,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Volledig scherm splash afbeelding (goudkleurig)
          Image.asset(
            'assets/splash_screen.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: LogdCodes.uiBlueBg);
            },
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Text(
                  "Legend of the\nGolden Dragon",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: LogdCodes.retroFont,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(color: Colors.amber),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
