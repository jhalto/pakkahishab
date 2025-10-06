import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/core/helper/validation_helper.dart';
import 'package:pakkahishab/core/utils/show_snackbar.dart';
import 'package:pakkahishab/features/auth/data/repositories/auth_repository.dart';
import 'package:pakkahishab/routes/app_routes.dart';

final loginNotifierProvider =
    NotifierProvider.autoDispose<LoginNotifier, LoginState>(() {
      return LoginNotifier();
    });

class LoginState {
  final bool isNumberSaved;

  final String phone;
  final String password;
  final String phoneError;
  final String passwordError;
  final bool isLoading;

  const LoginState({
    this.isNumberSaved = false,
    this.phone = '',
    this.password = '',
    this.phoneError = '',
    this.passwordError = '',
    this.isLoading = false,
  });

  LoginState copyWith({
    bool? isNumberSaved,
    String? phone,
    String? password,
    String? phoneError,
    String? passwordError,
    bool? isLoading,
  }) {
    return LoginState(
      isNumberSaved: isNumberSaved ?? this.isNumberSaved,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      phoneError: phoneError ?? this.phoneError,
      passwordError: passwordError ?? this.passwordError,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class LoginNotifier extends Notifier<LoginState> {
  late final AuthRepository _repo;
  final phoneFocusNode = FocusNode();
  @override
  LoginState build() {
    _repo = ref.read(authRepositoryProvider);
    checkSavedNumber();
    return const LoginState();
  }

  void updatePhone(String value, BuildContext context) {
    final error = Validation.validatePhone(value, context) ?? '';
    state = state.copyWith(phone: value, phoneError: error);
  }

  void updatePassword(String value, BuildContext context) {
    final error = Validation.validatePassword(value, context) ?? '';
    state = state.copyWith(password: value, passwordError: error);
  }

  Future<bool> checkSavedNumber() async {
    final number = await SharedPreferencesHelper.getString('login_phone');
    print(number);
    if (number != null && number.isNotEmpty) {
      state = state.copyWith(isNumberSaved: true, phone: number);
      // 👇 Request focus after widget tree builds
      WidgetsBinding.instance.addPostFrameCallback((_) {
        phoneFocusNode.requestFocus();
      });
      return true;
    }
    return false;
  }

  Future<void> login(BuildContext context) async {
    final phoneError = Validation.validateName(state.phone, context) ?? '';
    final passwordError =
        Validation.validatePassword(state.password, context) ?? '';

    state = state.copyWith(
      phoneError: phoneError,
      passwordError: passwordError,
    );

    if (phoneError.isNotEmpty || passwordError.isNotEmpty) return;

    state = state.copyWith(isLoading: true);

    try {
      final response = await _repo.login(
        username: state.phone,
        password: state.password,
      );
      print(response);
      print(response['statusCode']);

      if (response['status'] == 'success') {
        await Future.wait([
          SharedPreferencesHelper.saveString('name', response['username']),
          SharedPreferencesHelper.saveString(
            'company',
            response['Company Name'],
          ),
          SharedPreferencesHelper.saveString('phone', response['Mobile']),
          SharedPreferencesHelper.saveString('email', response['Email']),
        ]);
        state = state.copyWith(phone: '', password: '');
        if (!context.mounted) return;

        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.navbar,
          (route) => false,
        );

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
