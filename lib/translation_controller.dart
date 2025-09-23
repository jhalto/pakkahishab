import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';



class TranslationState {
   final Locale appLocale;

  const TranslationState({this.appLocale = const Locale('bn')});

   TranslationState copyWith ({Locale? appLocale}) => TranslationState(appLocale: appLocale ?? this.appLocale);
}


class TranslationNotifier extends Notifier<TranslationState> {

    @override
      TranslationState build(){
      _loadSavedLanguage();
      return const TranslationState();
    }
  Future<void> _loadSavedLanguage() async {
    final sp = await SharedPreferences.getInstance();
    final code = sp.getString('language_code') ?? 'bn';
     state = state.copyWith(appLocale: Locale(code));
  }

  Future<void> changeLanguage(Locale type) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString('language_code', type.languageCode);
    state = state.copyWith(appLocale: type);
  }
}