import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/shared/services/auth_services.dart';


final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final service = ref.read(authServiceProvider);
  return AuthRepository(service);
});

class AuthRepository {
  final AuthService _service;

  AuthRepository(this._service);

    Future<Map<String ,dynamic>> registerUser({
    required String companyName,
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    return _service.register(
      username: name,
      companyName: companyName,
      password: password,
      email: email,
      mobile: phone,
    );
  }
   Future<Map<String, dynamic>> login({required String username,required String password}) {
    return _service.login(username: username, password: password);
  }
}