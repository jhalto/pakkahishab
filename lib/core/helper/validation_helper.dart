import 'package:flutter/material.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';

class Validation {
  static String? validateName(String? value, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) {
      return loc.nameRequired;
    }
    if (value.trim().length < 3) {
      return loc.nameTooShort;
    }
    return null;
  }

  static String? validateCompany(String? value, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) {
      return loc.companyRequired;
    }
    return null;
  }

  static String? validateEmail(String? value, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) {
      return loc.emailRequired;
    }

    const pattern = r'^[\w\.-]+@([\w-]+\.)+[a-zA-Z]{2,}$';
    final regex = RegExp(pattern);

    if (!regex.hasMatch(value.trim())) {
      return loc.invalidEmail;
    }

    return null;
  }

  static bool isValidBangladeshiPhone(String phone) {
    final pattern = RegExp(r'^(?:\+88)?01[3-9]\d{8}$');
    return pattern.hasMatch(phone);
  }

  static String? validatePhone(String? value, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) {
      return loc.phoneRequired;
    }
    if (!isValidBangladeshiPhone(value.trim())) {
      return loc.invalidPhone;
    }
    return null;
  }

  static String? validatePassword2(String? value, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.isEmpty) {
      return loc.passwordRequired;
    }

    if (value.length < 8) {
      return loc.passwordTooShort;
    }

    const pattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    final regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return loc.invalidPassword;
    }
    return null;
  }

  static String? validatePassword(String? value, BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    // if (value == null || value.isEmpty) {
    //   return loc.passwordRequired; // you can change this to loc.pinRequired
    // }

    // // Check if length is between 4 and 5
    // if (value.length < 4 || value.length > 5) {
    //   return loc
    //       .passwordTooShort; // you can change this to loc.invalidPinLength
    // }

    // // Check if it contains only digits
    // final regex = RegExp(r'^\d{4,5}$');
    // if (!regex.hasMatch(value)) {
    //   return loc.invalidPassword; // you can change this to loc.invalidPin
    // }

    return null;
  }
}
