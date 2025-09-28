
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/auth/data/services/auth_services.dart';


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
   
   Future<Map<String, dynamic>> verifyNumber({required String phone})async{
       return _service.verifyNumber(phone: phone);
   }

   Future<Map<String, dynamic>> sendOtp({required String phone})async {
       return _service.sendOtp(phone: phone);
     
   }
}