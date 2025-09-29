import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/urls.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

class AuthService {
  Future<Map<String, dynamic>> register({
    required String username,
    required String password,
    required String companyName,
    required String mobile,
    required String email,
    required String otp,
  }) async {
    final url = Uri.parse("${Urls.baseUrl}registration/");

    final body = {
      "USERNAME": username,
      "PASSWORD": password,
      "COMPANY_NAME": companyName,
      "PRESENT_STATUS": "Y",
      "MOBILE": mobile,
      "EMAIL": email,
      "OTP_CODE": otp,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      // Initialize default values
      Map<String, dynamic> data = {};
      bool success = false;
      String message = "Unknown error occurred";

      // Check if response is JSON
      if ((response.headers['content-type'] ?? '').contains(
        'application/json',
      )) {
        if (response.body.isNotEmpty) {
          data = jsonDecode(response.body);
        }
      } else {
        // Not JSON (HTML page or error page)
        print("⚠️ Response is not JSON: ${response.body}");
        message = "Server returned unexpected response";
      }

      if (response.statusCode == 200) {
        success = true;
        message = data['message'] ?? "Registration successful";
      } else {
        message =
            data['message'] ??
            "Registration failed with status ${response.statusCode}";
      }

      print(success ? "✅ $message" : "❌ $message");

      return {"success": success, "message": message};
    } catch (e) {
      print("⚠️ Error during registration: $e");
      return {"success": false, "message": "Error: $e"};
    }
  }

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse("${Urls.baseUrl}login/");

    final body = {"username": username, "password": password};

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.body.isNotEmpty) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        return {"status": "error", "message": "Empty response from server"};
      }
    } catch (e) {
      return {"status": "error", "message": "Error: $e"};
    }
  }

  Future<Map<String, dynamic>> verifyNumber({required String phone}) async {
    final url = Uri.parse("${Urls.baseUrl}check_mobile_no/?MOBILE=$phone");

    try {
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.body.isNotEmpty) {
        return jsonDecode(response.body);
      } else {
        return {"status": "error", "message": "Empty response from server"};
      }
    } catch (e) {
      return {"status": "error", "message": "Error: $e"};
    }
  }

  Future<Map<String, dynamic>> sendOtp({required String phone}) async {
    final url = Uri.parse("${Urls.baseUrl2}send-otp");

    final body = {"auth_token": Urls.authToken, "phone": phone};
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
      );
      print(response.body);
      print(response.statusCode);
      if (response.body.isNotEmpty) {
        final responseData = jsonDecode(response.body);
        return {"statusCode": response.statusCode, "data": responseData};
      } else {
        return {
          "statusCode": response.statusCode,
          "status": "error",
          "message": "response body is empty",
        };
      }
    } catch (e) {
      print(e);
      return {"statusCode": "666", "status": "error", "message": "$e"};
    }
  }

  Future<Map<String, dynamic>> changeNumber({required String phone}) async {
    final url = Uri.parse("${Urls.baseUrl2}change-number-and-send-otp");

    final body = {"auth_token": Urls.authToken, "phone": phone};
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
      );
      print(response.body);
      if (response.body.isNotEmpty) {
        final responseData = jsonDecode(response.body);
        return {"statusCode": response.statusCode, "data": responseData};
      } else {
        return {
          "statusCode": response.statusCode,
          "status": "error",
          "message": "response body is empty",
        };
      }
    } catch (e) {
      print(e);
      return {"statusCode": "666", "status": "error", "message": "$e"};
    }
  }

  Future<Map<String, dynamic>> resendOtp({required String phone}) async {
    final url = Uri.parse("${Urls.baseUrl2}resend-otp");

    final body = {"auth_token": Urls.authToken, "phone": phone};
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
      );
      print(response.body);
      if (response.body.isNotEmpty) {
        final responseData = jsonDecode(response.body);
        return {"statusCode": response.statusCode, "data": responseData};
      } else {
        return {
          "statusCode": response.statusCode,
          "status": "error",
          "message": "response body is empty",
        };
      }
    } catch (e) {
      print(e);
      return {"statusCode": "666", "status": "error", "message": "$e"};
    }
  }

  Future<Map<String, dynamic>> confirmOtp({
    required String phone,
    required String otp,
  }) async {
    final url = Uri.parse("${Urls.baseUrl2}verify-otp");

    final body = {
      "auth_token": Urls.authToken,
      "phone": phone,
      "otp_code": otp,
    };
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
      );
      print(response.body);
      if (response.body.isNotEmpty) {
        final responseData = jsonDecode(response.body);
        return {"statusCode": response.statusCode, "data": responseData};
      } else {
        return {
          "statusCode": response.statusCode,
          "status": "error",
          "message": "response body is empty",
        };
      }
    } catch (e) {
      print(e);
      return {"statusCode": "666", "status": "error", "message": "$e"};
    }
  }
}
