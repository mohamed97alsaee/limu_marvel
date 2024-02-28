import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:limu_marvel/main.dart';
import 'package:limu_marvel/providers/auth_provider.dart';
import 'package:limu_marvel/screens/register_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> loginForm = GlobalKey<FormState>();

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginForm,
        onChanged: () {
          loginForm.currentState!.validate();
          setState(() {});
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(hintText: "Phone"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter your phonr";
                    }
                    if (value.length != 10) {
                      return "phone must be 10 digits at least";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: hidePassword,
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter your password";
                    }

                    if (value.length < 8) {
                      return "Password must be 8 charcter at least";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(hidePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      hintText: "Password"),
                ),
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
                const SizedBox(
                  height: 35,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Provider.of<AuthProvider>(context, listen: false)
                                .login({
                              "phone": phoneController.text,
                              "password": passwordController.text
                            }, context).then((logedIn) {
                              if (logedIn) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const ScreenRouter()),
                                    (route) => false);
                              }
                            });
                          },
                          child: const Text("LOGIN")),
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
