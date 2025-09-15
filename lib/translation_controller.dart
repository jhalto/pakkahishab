import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslationController with ChangeNotifier {
  Locale? _appLocale;
  Locale get appLocale => _appLocale ?? const Locale('en');

  TranslationController() {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final sp = await SharedPreferences.getInstance();
    final code = sp.getString('language_code') ?? 'en';
    _appLocale = Locale(code);
    notifyListeners();
  }

  Future<void> changeLanguage(Locale type) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString('language_code', type.languageCode);
    _appLocale = type;
    notifyListeners();
  }
}