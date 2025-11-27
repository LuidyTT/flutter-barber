import 'package:flutter/material.dart';
import 'package:flutter_barber/pages/auth_pages.dart';
import 'package:flutter_barber/pages/home_page.dart';
import 'package:flutter_barber/pages/booking_page.dart';
import 'package:flutter_barber/pages/cart_page.dart';
import 'package:flutter_barber/pages/payment_page.dart';
import 'package:flutter_barber/pages/barbers_page.dart';
import 'package:flutter_barber/pages/profile_page.dart';

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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff6C63FF),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xffF8F9FA),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff6C63FF),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xff1A1D21),
      ),
      home: const AuthPage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/booking': (context) => const BookingPage(),
        '/cart': (context) => const CartPage(),
        '/payment': (context) => const PaymentPage(),
        '/barbers': (context) => const BarbersPage(),
        '/profile': (context) => const ProfilePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
