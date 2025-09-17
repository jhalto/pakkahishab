import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pakkahishab/core/helper/validation_helper.dart';
import 'package:pakkahishab/core/utils/show_snackbar.dart';
import 'package:pakkahishab/features/auth/data/repositories/auth_repository.dart';
import 'package:pakkahishab/routes/app_routes.dart';

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

  void updateName(String value, BuildContext context) {
    _phone = value;
    _phoneError = Validation.validateName(value, context) ?? '';
    notifyListeners();
  }

  void updatePassword(String value, BuildContext context) {
    _password = value;
    _passwordError = Validation.validatePassword(value, context) ?? '';
    notifyListeners();
  }

 Future<void> login(BuildContext context) async {
  // Run final validation
  _phoneError = Validation.validateName(_phone, context) ?? '';
  _passwordError = Validation.validatePassword(_password, context) ?? '';
  notifyListeners();

  if (_phoneError.isNotEmpty || _passwordError.isNotEmpty) {
    return;
  }

  _isLoading = true;
  notifyListeners();

  try {
    final result = await _repo.login(
      username: _phone,
      password: _password,
    );

    print("📩 API Response: $result");

    if (result['status'] == 'success') {
      if (!context.mounted) return;

      // Navigate to home
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.home,
        (Route<dynamic> route) => false,
      );

      showCustomSnackBar(
        context,
        result['message'] ?? "Login successful",
        type: SnackBarType.success,
      );
    } else {
      if (!context.mounted) return;
      showCustomSnackBar(
        context,
        result['message'] ?? "Login failed",
        type: SnackBarType.error,
      );
    }
  } catch (e) {
    if (!context.mounted) return;
    showCustomSnackBar(
      context,
      "Something went wrong: $e",
      type: SnackBarType.error,
    );
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}
}
