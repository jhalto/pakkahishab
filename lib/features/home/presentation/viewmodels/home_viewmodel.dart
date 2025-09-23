import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
final homeProvider =
    StateNotifierProvider<HomeNotifier, HomeState>((ref) => HomeNotifier());

class HomeState {
  final String name;
  final String email;
  final String phone;
  final String company;
  final List<String> items;
  final List<IconData> icons;

  HomeState({
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
    required this.items,
    required this.icons,
  });

  HomeState copyWith({
    String? name,
    String? email,
    String? phone,
    String? company,
    List<String>? items,
    List<IconData>? icons,
  }) {
    return HomeState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      company: company ?? this.company,
      items: items ?? this.items,
      icons: icons ?? this.icons,
    );
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier()
      : super(
          HomeState(
            name: '',
            email: '',
            phone: '',
            company: '',
            items: [
              "expenses",
              "income",
              "stock",
              "advance",
              "loan",
              "cash",
            ],
            icons: [
              FontAwesomeIcons.bangladeshiTakaSign,
              FontAwesomeIcons.bangladeshiTakaSign,
              FontAwesomeIcons.bangladeshiTakaSign,
              FontAwesomeIcons.bangladeshiTakaSign,
              FontAwesomeIcons.bangladeshiTakaSign,
              FontAwesomeIcons.bangladeshiTakaSign,
            ],
          ),
        ) {
    loadUserData();
  }

  Future<void> loadUserData() async {
    final results = await Future.wait([
      SharedPreferencesHelper.getString('name'),
      SharedPreferencesHelper.getString('email'),
      SharedPreferencesHelper.getString('phone'),
      SharedPreferencesHelper.getString('company'),
    ]);

    state = state.copyWith(
      name: results[0] ?? '',
      email: results[1] ?? '',
      phone: results[2] ?? '',
      company: results[3] ?? '',
    );
  }

  Future<void> logout(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    await sp.clear();
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
  }
}

