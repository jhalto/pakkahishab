import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/home/data/models/dashboard_count_model.dart';
import 'package:pakkahishab/features/home/data/repositories/home_repository.dart';
import 'package:pakkahishab/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>(
  (ref) {
    final repo = ref.watch(homeRepositoryProvider);
    return HomeNotifier(repo);
  },
);

class HomeState {
  final String name;
  final String email;
  final String phone;
  final String company;
  final List<String> items;
  final List<IconData> icons;
  List<DashboardItem> dashboardItem;

  HomeState({
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
    required this.items,
    required this.icons,
    required this.dashboardItem,
  });

  HomeState copyWith({
    String? name,
    String? email,
    String? phone,
    String? company,
    List<String>? items,
    List<IconData>? icons,
    List<DashboardItem>? dashboardItem,
  }) {
    return HomeState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      company: company ?? this.company,
      items: items ?? this.items,
      icons: icons ?? this.icons,
      dashboardItem: dashboardItem ?? this.dashboardItem,
    );
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeRepository repository;
  HomeNotifier(this.repository)
    : super(
        HomeState(
          name: '',
          email: '',
          phone: '',
          company: '',
          items: ["expenses", "income", "stock", "advance", "loan", "cash"],

          icons: [
            FontAwesomeIcons.bangladeshiTakaSign,
            FontAwesomeIcons.bangladeshiTakaSign,
            FontAwesomeIcons.bangladeshiTakaSign,
            FontAwesomeIcons.bangladeshiTakaSign,
            FontAwesomeIcons.bangladeshiTakaSign,
            FontAwesomeIcons.bangladeshiTakaSign,
          ],
          dashboardItem: const [],
        ),
      ) {
    loadUserData();
     fetchDashBoard();
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

  Future<void> fetchDashBoard() async {
    try {
      final dashboardResponse = await repository.fetchDashBoard();
      if (dashboardResponse != null) {
        state = state.copyWith(dashboardItem: dashboardResponse.items);
      }
      print(state.dashboardItem.length);
    } catch (e) {
      print("Error fetching dashboard: $e");
    }
  }
  String getAmountByMetric(String metric) {
  try {
    final item = state.dashboardItem.firstWhere(
      (element) => element.metric.toLowerCase() == metric.toLowerCase(),
    );
    return item.amount.toInt().toString();
  } catch (e) {
    // If metric not found, return 0
    return '';
  }
}
}
