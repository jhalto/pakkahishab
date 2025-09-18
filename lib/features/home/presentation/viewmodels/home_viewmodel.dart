import 'package:flutter/material.dart';

import 'package:flutter_riverpod/legacy.dart';

import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';


final homeViewModelProvider = ChangeNotifierProvider((ref) => HomeViewmodel(),);

class HomeViewmodel extends ChangeNotifier {

  HomeViewmodel(){
     loadUserData();
  }

  String _name = '';
  String _company = '';
  String _email = '';
  String _phone = '';

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

}
