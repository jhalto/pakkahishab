import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/core/helper/validation_helper.dart';
import 'package:pakkahishab/core/utils/show_snackbar.dart';
import 'package:pakkahishab/features/auth/data/repositories/auth_repository.dart';
import 'package:pakkahishab/routes/app_routes.dart';

final loginNotifierProvider = NotifierProvider<LoginNotifier, LoginState>(() {
  return LoginNotifier();
});

class LoginState {
  final String name;
  final String password;
  final String nameError;
  final String passwordError;
  final bool isLoading;

  const LoginState({
    this.name = '',
    this.password = '',
    this.nameError = '',
    this.passwordError = '',
    this.isLoading = false,
  });

  LoginState copyWith({
    String? name,
    String? password,
    String? nameError,
    String? passwordError,
    bool? isLoading,
  }) {
    return LoginState(
      name: name ?? this.name,
      password: password ?? this.password,
      nameError: nameError ?? this.nameError,
      passwordError: passwordError ?? this.passwordError,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class LoginNotifier extends Notifier<LoginState> {
 late final AuthRepository _repo;



  @override
  LoginState build() {
    _repo = ref.read(authRepositoryProvider);
    return const LoginState();
  }

  void updateName(String value, BuildContext context) {
    final error = Validation.validateName(value, context) ?? '';
    state = state.copyWith(name: value, nameError: error);
  }

  void updatePassword(String value, BuildContext context) {
    final error = Validation.validatePassword(value, context) ?? '';
    state = state.copyWith(password: value, passwordError: error);
  }

  Future<void> login(BuildContext context) async {
    final nameError = Validation.validateName(state.name, context) ?? '';
    final passwordError =
        Validation.validatePassword(state.password, context) ?? '';

    state = state.copyWith(nameError: nameError, passwordError: passwordError);

    if (nameError.isNotEmpty || passwordError.isNotEmpty) return;

    state = state.copyWith(isLoading: true);

    try {
      final response = await _repo.login(
        username: state.name,
        password: state.password,
      );

      if (response['status'] == 'success') {
        await Future.wait([
          SharedPreferencesHelper.saveString('name', response['username']),
          SharedPreferencesHelper.saveString('company', response['Company Name']),
          SharedPreferencesHelper.saveString('phone', response['Mobile']),
          SharedPreferencesHelper.saveString('email', response['Email']),
        ]);

        if (!context.mounted) return;

        Navigator.pushNamedAndRemoveUntil(context, Routes.navbar, (route) => false);

        showCustomSnackBar(
          context,
          response['message'] ?? "Login successful",
          type: SnackBarType.success,
        );
      } else {
        if (!context.mounted) return;
        showCustomSnackBar(
          context,
          response['message'] ?? "Login failed",
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
      state = state.copyWith(isLoading: false);
    }
  }
}