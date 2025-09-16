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

    Future<void> registerUser({
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
   Future<void> loginUser(String phone, String password) {
    return _service.login(phone, password);
  }
}