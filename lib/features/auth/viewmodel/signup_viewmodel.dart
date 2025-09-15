import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pakkahishab/core/helper/validation_helper.dart';
import '../repositories/auth_repository.dart';

final signupViewModelProvider =
    ChangeNotifierProvider<SignupViewModel>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return SignupViewModel(repo);
});

class SignupViewModel extends ChangeNotifier {
  final AuthRepository _repo;

  SignupViewModel(this._repo);

  String _name = '';
  String _phone = '';
  String _password = '';
  String? _error = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String? get error => _error;

  void updateName(String value) {
    _name = value;
  }

  void updatePhone(String value) {
    _phone = value;
  }

  void updatePassword(String value) {
    _password = value;
  }

  Future<bool> register() async {
  final nameError = Validation.validateName(_name);
  final phoneError = Validation.validatePhone(_phone);
  final passwordError = Validation.validatePassword(_password);

  if (nameError != null || phoneError != null || passwordError != null) {
    _error = nameError ?? phoneError ?? passwordError;
    notifyListeners();
    return false;
  }

  _isLoading = true;
  notifyListeners();

  try {
    await _repo.registerUser(_name, _phone, _password);
    _isLoading = false;
    notifyListeners();
    return true;
  } catch (e) {
    _isLoading = false;
    _error = e.toString();
    notifyListeners();
    return false;
  }
}
}