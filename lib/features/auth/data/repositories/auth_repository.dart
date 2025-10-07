import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/auth/data/services/auth_services.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final service = ref.read(authServiceProvider);
  return AuthRepository(service);
});

class AuthRepository {
  final AuthService _service;

  AuthRepository(this._service);

  Future<Map<String, dynamic>> registerUser({
    required String companyName,
    required String name,
    required String phone,
    required String email,
    required String password,
    required String otp,
  }) {
    return _service.register(
      username: name,
      companyName: companyName,
      password: password,
      email: email,
      mobile: phone,
      otp: otp
    );
  }

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) {
    return _service.login(username: username, password: password);
  }

  Future<Map<String, dynamic>> verifyNumber({required String phone, required String email}) async {
    return _service.verifyNumber(phone: phone ,email: email);
  }

  Future<Map<String, dynamic>> sendOtp({required String phone}) async {
    return _service.sendOtp(phone: phone);
  }

  Future<Map<String, dynamic>> changeNumber({required String phone}) async {
    return _service.changeNumber(phone: phone);
  }

  Future<Map<String, dynamic>> resendOtp({required String phone}) async {
    return _service.resendOtp(phone: phone);
  }

  Future<Map<String, dynamic>> confirmOtp({
    required String phone,
    required String otp,
  }) async {
    return _service.confirmOtp(phone: phone, otp: otp);
  }
}
