import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:limu_marvel/helpers/consts.dart';
import 'package:limu_marvel/screens/home_screen.dart';
import 'package:limu_marvel/screens/login_screen.dart';
import 'package:limu_marvel/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  bool haveToken = false;

  checkStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    if (token != null) {
      setState(() {
        haveToken = true;
      });
    } else {
      setState(() {
        haveToken = false;
      });
    }
  }

  @override
  void initState() {
    checkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return haveToken ?const HomeScreen() : const LoginScreen();
  }
}
