import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pakkahishab/core/helper/validation_helper.dart';
import 'package:pakkahishab/features/auth/repositories/auth_repository.dart';

final loginViewModelProvider = ChangeNotifierProvider<LoginViewModel>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return LoginViewModel(repo);
});

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _repo;

  LoginViewModel(this._repo);

  String _phone = '';
  String _phoneError = '';
  String _password = '';
  String _passwordError = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String get phoneError => _phoneError;
  String get passwordError => _passwordError;

  void updatePhone(String value) {
    _phone = value;
    _phoneError = Validation.validatePhone(value) ?? '';
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    _passwordError = Validation.validatePassword(value) ?? '';
    notifyListeners();
  }

  Future<bool> login() async {
    // Run final validation
    _phoneError = Validation.validatePhone(_phone) ?? '';
    _passwordError = Validation.validatePassword(_password) ?? '';
    notifyListeners();

    if (_phoneError.isNotEmpty || _passwordError.isNotEmpty) {
      return false;
    }

    _isLoading = true;
    notifyListeners();
    Future.delayed(Duration(seconds: 1));
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
