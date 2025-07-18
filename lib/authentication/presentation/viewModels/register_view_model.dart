import 'package:flutter/material.dart';
import 'package:movies_app/authentication/data/api_services.dart';
import 'package:movies_app/authentication/data/models/register_response.dart';

class RegisterViewModel extends ChangeNotifier {
  String message = '';
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required int avatarId,
  }) async {
    RegisterResponse response = await ApiServices.register(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        phoneNumber: phoneNumber,
        avatarId: avatarId);
    message = response.message;
    notifyListeners();
  }
}
