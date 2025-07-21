import 'package:flutter/material.dart';
import 'package:movies_app/authentication/data/api_services.dart';
import 'package:movies_app/authentication/data/models/login_response.dart';
import 'package:movies_app/authentication/data/shared_prefs.dart';

class LoginViewModel extends ChangeNotifier {
  String message = '';
  String token = '';
  Future<void> login({
    required String email,
    required String password,
  }) async {
    LoginResponse response = await ApiServices.login(
      email: email,
      password: password,
    );
    message = response.message;
    token = response.token ?? '';

    if (token.isNotEmpty) {
      await SharedPrefs.saveToken(token);
    }
    notifyListeners();
  }
}
