import 'dart:convert';

import 'package:genxshop/data/models/login_response_model.dart';

import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final String baseUrl = "https://product-management-seven-xi.vercel.app";

  Future<LoginResponse> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl//api/v1/auth/login'),
      headers: {"ContentType": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
        "fcmToken": "optional-fcm-token"
      }),
    );
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Login Failed');
    }
  }
}
