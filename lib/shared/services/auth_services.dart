import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

class AuthService {
  Future<void> register(String name, String phone, String password) async {
    // here you would normally call FirebaseAuth, REST API, etc.
    await Future.delayed(const Duration(seconds: 2)); // simulate network call
    print("User registered: $name, $phone");
  }
   Future<void> login(String phone, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // simulate network
    if (phone != "1234567890" || password != "password") {
      throw Exception("Invalid credentials");
    }
    print("User logged in: $phone");
  }
}