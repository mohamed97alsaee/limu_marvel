import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:limu_marvel/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//   {
//    "phone":"0919247183",
//     "password":"12345678"
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextField(),
                const SizedBox(height: 20),
                TextFormField(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Dont have account ?"),
                    TextButton(
                      child: const Text("Create Account"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const RegisterScreen()));
                      },
                    ),
                  ],
                ),
             const   SizedBox(
                  height: 35,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text("LOGIN")),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
