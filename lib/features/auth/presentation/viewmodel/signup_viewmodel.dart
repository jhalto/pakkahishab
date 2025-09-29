import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pakkahishab/core/helper/validation_helper.dart';
import 'package:pakkahishab/core/utils/show_snackbar.dart';
import 'package:pakkahishab/features/auth/presentation/view/otp_view.dart';
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
  final bool isResendAvailable;
  final int secondsRemaining;
  final String name;
  final String companyName;
  final String email;
  final String phone;
  final String phone2;
  final String password;
  final String nameError;
  final String companyNameError;
  final String emailError;
  final String phoneError;
  final String passwordError;
  final bool isLoading;

  const SignupState({
    this.isResendAvailable = false,
    this.secondsRemaining = 0,
    this.name = '',
    this.companyName = '',
    this.email = '',
    this.phone = '',
    this.phone2 = '',
    this.password = '',
    this.nameError = '',
    this.companyNameError = '',
    this.emailError = '',
    this.passwordError = '',
    this.phoneError = '',
    this.isLoading = false,
  });

  SignupState copyWith({
    bool? isResendAvailable,
    int? secondsRemaining,
    String? name,
    String? companyName,
    String? email,
    String? phone,
    String? phone2,
    String? password,
    String? nameError,
    String? companyNameError,
    String? emailError,
    String? phoneError,
    String? passwordError,
    bool? isLoading,
  }) => SignupState(
    isResendAvailable: isResendAvailable ?? this.isResendAvailable,
    secondsRemaining: secondsRemaining ?? this.secondsRemaining,
    name: name ?? this.name,
    companyName: companyName ?? this.companyName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    phone2: phone2 ?? this.phone2,
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

  void updatePhone2(String value, BuildContext context) {
    final error = Validation.validatePhone(value, context) ?? '';
    state = state.copyWith(phone2: value, phoneError: error);
  }

  void updatePassword(String value, BuildContext context) {
    final error = Validation.validatePassword(value, context) ?? '';
    state = state.copyWith(password: value, passwordError: error);
  }

  Timer? _timer;
  void startResendTimer() {
    state = state.copyWith(isResendAvailable: false);
    state = state.copyWith(secondsRemaining: 60);

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining > 0) {
        state = state.copyWith(secondsRemaining: state.secondsRemaining - 1);
      } else {
        state = state.copyWith(isResendAvailable: true);
        timer.cancel();
      }
    });
  }

  Future<void> register({
    required BuildContext context,
    required String otp,
  }) async {
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
        otp: otp,
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

  Future<void> verifyNumber(BuildContext context) async {
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
      final result = await _repo.verifyNumber(phone: state.phone);
      print(result);
      if (result['status'] == 'success') {
        if (!context.mounted) return;

        await sendOtp(context, state.phone);
      } else {
        state = state.copyWith(isLoading: false);
        if (!context.mounted) return;
        showCustomSnackBar(context, "This mobile number is already registered");
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print(e);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> verifyNumber2(BuildContext context) async {
    final phoneError = Validation.validatePhone(state.phone2, context) ?? '';
    state = state.copyWith(phoneError: phoneError);
    if (phoneError.isNotEmpty) {
      return;
    }
    state = state.copyWith(isLoading: true);

    try {
      final result = await _repo.verifyNumber(phone: state.phone2);
      print(result);
      if (result['status'] == 'success') {
        state = state.copyWith(phone: state.phone2);
        if (!context.mounted) return;

        await changeNumber(context, state.phone);
      } else {
        state = state.copyWith(isLoading: false);
        if (!context.mounted) return;
        showCustomSnackBar(context, "This mobile number is already registered");
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print(e);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> sendOtp(BuildContext context, String phone) async {
    try {
      final result = await _repo.sendOtp(phone: phone);

      if (result['statusCode'] == 200) {
        if (!context.mounted) return;

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtpView()),
        );
        startResendTimer();
        showCustomSnackBar(
          context,
          "Otp sent successfully",
          type: SnackBarType.success,
        );
      } else if (result['statusCode'] == 401) {
        if (!context.mounted) return;
        showCustomSnackBar(context, "Unauthorized");
      } else if (result['statusCode'] == 422) {
        if (!context.mounted) return;
        showCustomSnackBar(context, "The phone field is required");
      } else if (result['statusCode'] == 429) {
        if (!context.mounted) return;
        showCustomSnackBar(
          context,
          "You have reached the maximum number of OTP requests",
        );
      } else if (result['statusCode'] == 500) {
        if (!context.mounted) return;
        showCustomSnackBar(
          context,
          "Failed to send OTP. Please try again later",
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> changeNumber(BuildContext context, String phone) async {
    state = state.copyWith(isLoading: true);
    try {
      final result = await _repo.changeNumber(phone: phone);

      if (result['statusCode'] == 200) {
        if (!context.mounted) return;

        Navigator.pop(context);
        startResendTimer();
        showCustomSnackBar(
          context,
          "Otp sent successfully",
          type: SnackBarType.success,
        );
      } else if (result['statusCode'] == 401) {
        if (!context.mounted) return;
        showCustomSnackBar(context, "Unauthorized");
      } else if (result['statusCode'] == 429) {
        if (!context.mounted) return;
        showCustomSnackBar(
          context,
          "You have reached the maximum number of OTP requests",
        );
      }
    } catch (e) {
      print(e);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> resendOtp(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      final result = await _repo.resendOtp(phone: state.phone);

      if (result['statusCode'] == 200) {
        if (!context.mounted) return;

        startResendTimer();
        showCustomSnackBar(
          context,
          "Otp sent successfully",
          type: SnackBarType.success,
        );
      } else if (result['statusCode'] == 401) {
        if (!context.mounted) return;
        showCustomSnackBar(context, "Unauthorized");
      } else if (result['statusCode'] == 429) {
        if (!context.mounted) return;
        showCustomSnackBar(
          context,
          "You have reached the maximum number of OTP requests",
        );
      }
    } catch (e) {
      print(e);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> confirmOtp(BuildContext context, {required String otp}) async {
    state = state.copyWith(isLoading: true);
    try {
      final result = await _repo.confirmOtp(phone: state.phone, otp: otp);
      print(result['data']);
      if (result['statusCode'] == 200) {
        if (!context.mounted) return;
        await register(context: context, otp: otp);
      } else if (result['statusCode'] == 401) {
        if (!context.mounted) return;
        showCustomSnackBar(context, "Unauthorized");
      } else if (result['statusCode'] == 422) {
        if (!context.mounted) return;
        showCustomSnackBar(context, "The otp_code must be 4 digits");
      } else if (result['statusCode'] == 400) {
        if (!context.mounted) return;
        showCustomSnackBar(context, "The otp_code is not valid");
      } else if (result['statusCode'] == 429) {
        if (!context.mounted) return;
        showCustomSnackBar(
          context,
          "You have reached the maximum number of OTP requests",
        );
      }
    } catch (e) {
      print(e);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
