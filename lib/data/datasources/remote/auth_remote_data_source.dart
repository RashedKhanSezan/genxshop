import 'dart:convert';

import 'package:genxshop/data/models/login_response_model.dart';

import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final String baseUrl = "https://product-management-seven-xi.vercel.app/api/v1";

  Future<void> register(String name, String email, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/users/register'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "fullName": name,
          "email": email,
          "password": password,
          "fcmToken": "optional-fcm-token",
        }));

    print("REGISTER STATUS: ${response.statusCode}");
    print("REGISTER BODY: ${response.body}");

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Registration failed: ${response.body}");
    }
  }

  Future<LoginResponse> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
        "fcmToken": "optional-fcm-token"
      }),
    );
    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Login Failed');
    }
  }
}
