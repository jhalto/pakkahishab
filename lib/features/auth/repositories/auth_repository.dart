import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/shared/services/auth_services.dart';


final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final service = ref.read(authServiceProvider);
  return AuthRepository(service);
});

class AuthRepository {
  final AuthService _service;

  AuthRepository(this._service);

  Future<void> registerUser(String name, String phone, String password) {
    return _service.register(name, phone, password);
  }
   Future<void> loginUser(String phone, String password) {
    return _service.login(phone, password);
  }
}