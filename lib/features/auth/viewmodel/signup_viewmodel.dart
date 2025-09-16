import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pakkahishab/core/helper/validation_helper.dart';
import '../repositories/auth_repository.dart';

final signupViewModelProvider =
    ChangeNotifierProvider.autoDispose<SignupViewModel>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return SignupViewModel(repo);
});

class SignupViewModel extends ChangeNotifier {
  final AuthRepository _repo;

  SignupViewModel(this._repo);

  String _userName = '';
  String _companyName = '';
  String _userEmail = '';
  String _phone = '';
  String _password = '';

  String _nameError = '';
  String _companyError = '';
  String _emailError = '';
  String _phoneError = '';
  String _passwordError = '';

  bool _isLoading = false;

  // Getters
  bool get isLoading => _isLoading;
  String get nameError => _nameError;
  String get companyError => _companyError;
  String get emailError => _emailError;
  String get phoneError => _phoneError;
  String get passwordError => _passwordError;

  // Update fields with live validation
   void updateCompany(String value) {
    _companyName = value;
    _companyError = Validation.validateCompany(value) ?? '';
    notifyListeners();
  }
  void updateName(String value) {
    _userName = value;
    _nameError = Validation.validateName(value) ?? '';
    notifyListeners();
  }
  void updateEmail(String value) {
    _userEmail = value;
    _emailError = Validation.validateEmail(value) ?? '';
    notifyListeners();
  }

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

  Future<bool> register() async {
    // Run final validation
    _nameError = Validation.validateName(_userName) ?? '';
    _companyError = Validation.validateName(_companyName) ?? '';
    _phoneError = Validation.validatePhone(_phone) ?? '';
    _passwordError = Validation.validatePassword(_password) ?? '';
    _emailError = Validation.validateEmail(_userEmail) ?? '';
    notifyListeners();

    if (_companyError.isNotEmpty || _nameError.isNotEmpty || _phoneError.isNotEmpty || _passwordError.isNotEmpty || _emailError.isNotEmpty ) {
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await _repo.registerUser(name: _userName,phone:   _phone,password:  _password ,companyName:  _companyName,email: _userEmail);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _nameError = e.toString(); // you could handle differently
      notifyListeners();
      return false;
    }
  }
}
