import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  Future<bool> login(Map loginBody, context) async {
    bool isLogedIn = false;
    final response = await http
        .post(Uri.parse("http://todo.kudo.ly/api/user/login"), body: loginBody);
    debugPrint("POST ON: http://todo.kudo.ly/api/user/login");
    debugPrint("SENT BODY: $loginBody");
    debugPrint("STATUS CODE: ${response.statusCode}");
    debugPrint("POST RES: ${response.body}");

    if (response.statusCode == 200) {
      isLogedIn = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", json.decode(response.body)['access_token']);
    } else {
      isLogedIn = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login Failed")));
    }
    return isLogedIn;
  }

  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    return true;
  }
}
