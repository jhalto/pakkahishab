import 'package:flutter_riverpod/legacy.dart';
import '../repositories/auth_repository.dart';
import 'package:flutter/material.dart';

final loginViewModelProvider =
    ChangeNotifierProvider<LoginViewModel>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return LoginViewModel(repo);
});

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _repo;

  LoginViewModel(this._repo);

  String _phone = '';
  String _password = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void updatePhone(String value) {
    _phone = value;
  }

  void updatePassword(String value) {
    _password = value;
  }

  Future<bool> login() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repo.loginUser(_phone, _password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}