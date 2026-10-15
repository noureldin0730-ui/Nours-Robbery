// ============================================================
// NOUR'S ROBBERY
// A stealth game by Nour Eldin
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/menu_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // شاشة عرضية إجبارية
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // شاشة كاملة بدون status bar
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const NourRobberyApp());
}

class NourRobberyApp extends StatelessWidget {
  const NourRobberyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Nour's Robbery",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0A0A14),
        fontFamily: 'monospace',
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFD54A),
          secondary: Color(0xFF4AD7FF),
        ),
      ),
      // نقطة البداية + الـ routes
      initialRoute: '/',
      routes: {
        '/': (_) => const MenuScreen(),
      },
    );
  }
}