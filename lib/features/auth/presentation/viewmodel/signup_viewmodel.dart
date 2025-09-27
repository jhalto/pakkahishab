import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pakkahishab/core/helper/validation_helper.dart';
import 'package:pakkahishab/core/utils/show_snackbar.dart';
import 'package:pakkahishab/routes/app_routes.dart';
import '../../data/repositories/auth_repository.dart';

// final signupViewModelProvider = ChangeNotifierProvider<SignupViewModel>((ref) {
//   final repo = ref.read(authRepositoryProvider);
//   return SignupViewModel(repo);
// });
final signupNotifierProvider = NotifierProvider<SignupNotifier, SignupState>(
  () => SignupNotifier(),
);

class SignupState {
  final bool isNumberCheck;
  final String name;
  final String companyName;
  final String email;
  final String phone;
  final String password;
  final String nameError;
  final String companyNameError;
  final String emailError;
  final String phoneError;
  final String passwordError;
  final bool isLoading;

  const SignupState({
    this.isNumberCheck = false,
    this.name = '',
    this.companyName = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.nameError = '',
    this.companyNameError = '',
    this.emailError = '',
    this.passwordError = '',
    this.phoneError = '',
    this.isLoading = false,
  });

  SignupState copyWith({
    bool? isNumberCheck,
    String? name,
    String? companyName,
    String? email,
    String? phone,
    String? password,
    String? nameError,
    String? companyNameError,
    String? emailError,
    String? phoneError,
    String? passwordError,
    bool? isLoading,
  }) => SignupState(
    isNumberCheck: isNumberCheck ?? this.isNumberCheck,
    name: name ?? this.name,
    companyName: companyName ?? this.companyName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    password: password ?? this.password,
    nameError: nameError ?? this.nameError,
    companyNameError: companyNameError ?? this.companyNameError,
    emailError: emailError ?? this.emailError,
    phoneError: phoneError ?? this.phoneError,
    isLoading: isLoading ?? this.isLoading,
  );
}

class SignupNotifier extends Notifier<SignupState> {
  late final AuthRepository _repo;

  @override
  SignupState build() {
    _repo = ref.read(authRepositoryProvider);
    return const SignupState();
  }

  bool isNumberCheck = false;

  void updateCompany(String value, BuildContext context) {
    final error = Validation.validateCompany(value, context) ?? '';
    state = state.copyWith(companyName: value, companyNameError: error);
  }

  void updateName(String value, BuildContext context) {
    final error = Validation.validateName(value, context) ?? '';
    state = state.copyWith(name: value, nameError: error);
  }

  void updateEmail(String value, BuildContext context) {
    final error = Validation.validateEmail(value, context) ?? '';
    state = state.copyWith(email: value, emailError: error);
  }

  void updatePhone(String value, BuildContext context) {
    final error = Validation.validatePhone(value, context) ?? '';
    state = state.copyWith(phone: value, phoneError: error);
  }

  void updatePassword(String value, BuildContext context) {
    final error = Validation.validatePassword(value, context) ?? '';
    state = state.copyWith(password: value, passwordError: error);
  }

  Future<void> register(BuildContext context) async {
    final nameError = Validation.validateName(state.name, context) ?? '';
    final companyNameError =
        Validation.validateCompany(state.companyName, context) ?? '';
    final emailError = Validation.validateEmail(state.email, context) ?? '';
    final passwordError =
        Validation.validatePassword(state.password, context) ?? '';
    final phoneError = Validation.validatePhone(state.phone, context) ?? '';
    state = state.copyWith(
      nameError: nameError,
      companyNameError: companyNameError,
      phoneError: phoneError,
      emailError: emailError,
      passwordError: passwordError,
    );
    if (companyNameError.isNotEmpty ||
        nameError.isNotEmpty ||
        phoneError.isNotEmpty ||
        passwordError.isNotEmpty ||
        emailError.isNotEmpty) {
      return;
    }
    state = state.copyWith(isLoading: true);

    try {
      final result = await _repo.registerUser(
        name: state.name,
        phone: state.phone,
        password: state.password,
        companyName: state.companyName,
        email: state.email,
      );

      if (result['success'] == true) {
        if (!context.mounted) return;
        showCustomSnackBar(
          context,
          result['message'],
          type: SnackBarType.success,
        );
        Navigator.pushReplacementNamed(context, Routes.login);
      } else {
        if (!context.mounted) return;

        showCustomSnackBar(context, result['message']);
      }
    } catch (e) {
      "Something went wrong: $e";
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
