import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

class AuthService {
  Future<void> register({
    required String username,
    required String password,
    required String companyName,
    required String mobile,
    required String email,
  }) async {
    final url = Uri.parse(
      "http://202.0.94.62:8081/ords/dev/PakkahisabApp/registration/",
    );

    final body = {
      "USERNAME": username,
      "PASSWORD": password,
      "COMPANY_NAME": companyName,
      "PRESENT_STATUS": "Y", // default value
      "MOBILE": mobile,
      "EMAIL": email,
      "OTP_CODE": 123212, // default value
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print("✅ Registration successful: ${response.body}");
      } else {
        print(
          "❌ Registration failed: ${response.statusCode}, ${response.body}",
        );
        throw Exception("Failed to register user");
      }
    } catch (e) {
      print("⚠️ Error during registration: $e");
      rethrow;
    }
  }

  Future<void> login(String phone, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // simulate network
    if (phone != "1234567890" || password != "password") {
      throw Exception("Invalid credentials");
    }
    print("User logged in: $phone");
  }
}
