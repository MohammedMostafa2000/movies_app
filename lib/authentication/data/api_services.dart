import 'dart:convert';
import 'package:movies_app/authentication/data/models/login_response.dart';
import 'package:movies_app/authentication/data/models/register_response.dart';
import 'package:movies_app/authentication/data/models/user_data_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<RegisterResponse> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required int avatarId,
  }) async {
    final url = Uri.parse('https://route-movie-apis.vercel.app/auth/register');
    final user = UserDataModel(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phoneNumber,
      avatarId: avatarId,
    );
    final body = jsonEncode(user.toJson());
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      final json = jsonDecode(response.body);
      return RegisterResponse.fromJson(json);
    } catch (e) {
      return RegisterResponse(message: e.toString());
    }
  }

  static Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('https://route-movie-apis.vercel.app/auth/login');
    final user = UserDataModel(
      email: email,
      password: password,
    );
    final body = jsonEncode(user.toJson());
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      final json = jsonDecode(response.body);
      return LoginResponse.fromJson(json);
    } catch (e) {
      return LoginResponse(message: e.toString());
    }
  }
}
