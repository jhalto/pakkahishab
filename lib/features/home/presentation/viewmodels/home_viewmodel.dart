import 'package:flutter/material.dart';

import 'package:flutter_riverpod/legacy.dart';

import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

final homeViewModelProvider = ChangeNotifierProvider((ref) => HomeViewmodel());

class HomeViewmodel extends ChangeNotifier {
  HomeViewmodel() {
    loadUserData();
  }

  String _name = '';
  String _company = '';
  String _email = '';
  String _phone = '';

  final items = [

    "Expenses",
    "Income",
    "Stock",
   
  ];
  final icons = [
   // Customer Due
    Icons.money_off, // Expenses
    Icons.trending_up, // Income
    Icons.inventory, // Stock

  ];

  loadUserData() async {
    final results = await Future.wait([
      SharedPreferencesHelper.getString('name'),
      SharedPreferencesHelper.getString('email'),
      SharedPreferencesHelper.getString('phone'),
      SharedPreferencesHelper.getString('company'),
    ]);

    // Assign values (with fallback in case null)
    _name = results[0] ?? '';
    _email = results[1] ?? '';
    _phone = results[2] ?? '';
    _company = results[3] ?? '';

    notifyListeners(); // 🔔 Update UI
  }

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get company => _company;

  void logout(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    await sp.clear();
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
  }
}
