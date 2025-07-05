// main.dart
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() => runApp(ClockApp());

class ClockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
