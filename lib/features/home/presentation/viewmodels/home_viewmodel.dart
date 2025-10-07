import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/home/data/repositories/home_repository.dart';
import 'package:pakkahishab/routes/app_routes.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final repo = ref.watch(homeRepositoryProvider);
  return HomeNotifier(repo);
});

class HomeState {
  final String name;
  final String email;
  final String phone;
  final String company;

  final List<IconData> icons;
  final String cashInHand;
  final String cashAtBank;
  final String totalPurchase;
  final String totalSales;
  final String totalPayable;
  final String totalReceivable;
  final String expenses;
  final String income;
  final String stock;
  final String advance;
  final String loan;
  final String mobileBanking;
  final String filter;

  HomeState({
    required this.name,
    required this.email,
    required this.phone,
    required this.company,

    required this.icons,
    required this.cashInHand,
    required this.cashAtBank,
    required this.totalPurchase,
    required this.totalSales,
    required this.totalPayable,
    required this.totalReceivable,
    required this.expenses,
    required this.income,
    required this.stock,
    required this.advance,
    required this.loan,
    required this.mobileBanking,
    required this.filter,
  });

  HomeState copyWith({
    String? name,
    String? email,
    String? phone,
    String? company,

    List<IconData>? icons,

    String? cashInHand,
    String? cashAtBank,
    String? totalPurchase,
    String? totalSales,
    String? totalPayable,
    String? totalReceivable,
    String? expenses,
    String? income,
    String? stock,
    String? advance,
    String? loan,
    String? mobileBanking,
    String? filter,
  }) {
    return HomeState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      company: company ?? this.company,
      icons: icons ?? this.icons,
      cashInHand: cashInHand ?? this.cashInHand,
      cashAtBank: cashAtBank ?? this.cashAtBank,
      totalPurchase: totalPurchase ?? this.totalPurchase,
      totalSales: totalSales ?? this.totalSales,
      totalPayable: totalPayable ?? this.totalPayable,
      totalReceivable: totalReceivable ?? this.totalReceivable,
      expenses: expenses ?? this.expenses,
      income: income ?? this.income,
      stock: stock ?? this.stock,
      advance: advance ?? this.advance,
      loan: loan ?? this.loan,
      mobileBanking: mobileBanking ?? this.mobileBanking,
      filter: filter ?? this.filter,
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

          icons: [
            FontAwesomeIcons.bangladeshiTakaSign,
            FontAwesomeIcons.bangladeshiTakaSign,
            FontAwesomeIcons.bangladeshiTakaSign,
            FontAwesomeIcons.bangladeshiTakaSign,
            FontAwesomeIcons.bangladeshiTakaSign,
            FontAwesomeIcons.bangladeshiTakaSign,
          ],

          cashInHand: '',
          cashAtBank: '',
          totalPurchase: '',
          totalSales: '',
          totalPayable: '',
          totalReceivable: '',
          expenses: '',
          income: '',
          stock: '',
          advance: '',
          loan: '',
          mobileBanking: '',
          filter: 'YEAR',
        ),
      ) {
    loadUserData();
    fetchDashBoard(state.filter);
  }
  void updateFilter(String value){
   state = state.copyWith(filter: value);
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
    // final sp = await SharedPreferences.getInstance();
    // await sp.clear();
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
  }

  Future<void> fetchDashBoard(String filter) async {
    try {
      final dashboardResponse = await repository.fetchDashBoard(filter);
      if (dashboardResponse != null) {
        var updatedState = state;

        for (var item in dashboardResponse.items) {
          switch (item.metric.toLowerCase()) {
            case 'purchase':
              updatedState = updatedState.copyWith(
                totalPurchase: item.amount.toString(),
              );
              break;
            case 'sales':
              updatedState = updatedState.copyWith(
                totalSales: item.amount.toString(),
              );
              break;
            case 'expense':
              updatedState = updatedState.copyWith(
                expenses: item.amount.toString(),
              );
              break;
            case 'income':
              updatedState = updatedState.copyWith(
                income: item.amount.toString(),
              );
              break;
            case 'cash':
              updatedState = updatedState.copyWith(
                cashInHand: item.amount.toString(),
              );
              break;
            case 'stock':
              updatedState = updatedState.copyWith(
                stock: item.amount.toString(),
              );
              break;
            case 'supplier_due':
              updatedState = updatedState.copyWith(
                totalPayable: item.amount.toString(),
              );
              break;
            case 'customer_due':
              updatedState = updatedState.copyWith(
                totalReceivable: item.amount.toString(),
              );
              break;
            case 'bank':
              updatedState = updatedState.copyWith(
                cashAtBank: item.amount.toString(),
              );
              break;
            case 'mobile_banking':
              updatedState = updatedState.copyWith(
                mobileBanking: item.amount.toString(),
              );
              break;
            case 'advance':
              updatedState = updatedState.copyWith(
                advance: item.amount.toString(),
              );
              break;
            case 'loan':
              updatedState = updatedState.copyWith(
                loan: item.amount.toString(),
              );
              break;
          }
        }

        state = updatedState; // ✅ Only one rebuild
      }
    } catch (e) {
      print("Error fetching dashboard: $e");
    }
  }

  //   String getAmountByMetric(String metric) {
  //   try {
  //     final item = state.dashboardItem.firstWhere(
  //       (element) => element.metric.toLowerCase() == metric.toLowerCase(),
  //     );
  //     return item.amount.toInt().toString();
  //   } catch (e) {
  //     // If metric not found, return 0
  //     return '';
  //   }
  // }
}
