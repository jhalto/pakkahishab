import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pakkahishab/core/helper/validation_helper.dart';
import 'package:pakkahishab/core/utils/show_snackbar.dart';
import 'package:pakkahishab/routes/app_routes.dart';
import '../../data/repositories/auth_repository.dart';

final signupViewModelProvider = ChangeNotifierProvider<SignupViewModel>((ref) {
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
  final String _confirmPassword = '';

  String _nameError = '';
  final String _error = '';
  String _companyError = '';
  String _emailError = '';
  String _phoneError = '';
  String _passwordError = '';
  final String _confirmPasswordError = '';
  
  String? _errorMessage;
  String? _successMessage;

  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  bool _isLoading = false;

  // Getters
  bool get isLoading => _isLoading;
  String get nameError => _nameError;
  String get error => _error;
  String get companyError => _companyError;
  String get emailError => _emailError;
  String get phoneError => _phoneError;
  String get passwordError => _passwordError;
  String get confirmPasswordError => _confirmPasswordError;

  // Update fields with live validation
  void updateCompany(String value, BuildContext context) {
    _companyName = value;
    _companyError = Validation.validateCompany(value, context) ?? '';

    notifyListeners();
  }

  void updateName(String value, BuildContext context) {
    _userName = value;
    _nameError = Validation.validateName(value, context) ?? '';
    notifyListeners();
  }

  void updateEmail(String value, BuildContext context) {
    _userEmail = value;
    _emailError = Validation.validateEmail(value, context) ?? '';
    notifyListeners();
  }

  void updatePhone(String value, BuildContext context) {
    _phone = value;
    _phoneError = Validation.validatePhone(value, context) ?? '';
    notifyListeners();
  }

  void updatePassword(String value, BuildContext context) {
    _password = value;
    _passwordError = Validation.validatePassword(value, context) ?? '';
    notifyListeners();
  }

 Future<void> register(BuildContext context) async {
  // 1️⃣ Run validations
  _nameError = Validation.validateName(_userName,context) ?? '';
  _companyError = Validation.validateCompany(_companyName,context) ?? '';
  _phoneError = Validation.validatePhone(_phone,context) ?? '';
  _passwordError = Validation.validatePassword(_password,context) ?? '';
  _emailError = Validation.validateEmail(_userEmail,context) ?? '';
  notifyListeners();

  if (_companyError.isNotEmpty ||
      _nameError.isNotEmpty ||
      _phoneError.isNotEmpty ||
      _passwordError.isNotEmpty ||
      _emailError.isNotEmpty) {
    return;
  }

  _isLoading = true;
  _errorMessage = null;
  _successMessage = null;
  notifyListeners();

  try {
    final result = await _repo.registerUser(
      name: _userName,
      phone: _phone,
      password: _password,
      companyName: _companyName,
      email: _userEmail,
    );
     print(_companyName);
     print(_userName);
     print(_phone);
     print(_userEmail);
     print(_password);
    if (result['success'] == true) {
      _successMessage = result['message'];
      if(!context.mounted)return;
      showCustomSnackBar(context, result['message'], type: SnackBarType.success);
      Navigator.pushReplacementNamed(context, Routes.login);
    } else {
      _errorMessage = result['message'];
      if(!context.mounted)return;

      showCustomSnackBar(context, result['message']);
    }
  } catch (e) {
    _errorMessage = "Something went wrong: $e";
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}
}
