import 'package:flutter/material.dart';
import 'package:flutter_barber/pages/auth_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barber App',
      theme: ThemeData(
        // Use o tema claro como base
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff6C63FF),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xffF8F9FA),
      ),
      darkTheme: ThemeData(
        // Tema escuro
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff6C63FF),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xff1A1D21),
      ),
      home: const AuthPage(), // ← Aqui está a mudança principal
      debugShowCheckedModeBanner: false,
    );
  }
}
