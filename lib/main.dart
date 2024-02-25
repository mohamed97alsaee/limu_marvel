import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:limu_marvel/helpers/consts.dart';
import 'package:limu_marvel/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: false,
      ),
      home: const SplashScreen(),
    );
  }
}
