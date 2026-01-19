import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/home/data/repositories/home_repository.dart';
import 'package:pakkahishab/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

final homeProvider = NotifierProvider.autoDispose<HomeNotifier, HomeState>(
  () => HomeNotifier(),
);

class HomeState {
  final bool loading;
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

  const HomeState({
    this.loading = false,
    this.name = '',
    this.email = '',
    this.phone = '',
    this.company = '',
    this.icons = const [],
    this.cashInHand = '0',
    this.cashAtBank = '0',
    this.totalPurchase = '0',
    this.totalSales = '0',
    this.totalPayable = '0',
    this.totalReceivable = '0',
    this.expenses = '0',
    this.income = '0',
    this.stock = '0',
    this.advance = '0',
    this.loan = '0',
    this.mobileBanking = '0',
    this.filter = 'today',
  });

  HomeState copyWith({
    bool? loading,
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
      loading: loading ?? this.loading,
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

class HomeNotifier extends Notifier<HomeState> {
  late final HomeRepository _repo;

  @override
  HomeState build() {
    _repo = ref.read(homeRepositoryProvider);
    fetchDashBoard('ALL');
    return HomeState(
      icons: [
        Icons.shopping_cart,
        Icons.sell,
        Icons.money,
        Icons.account_balance,
      ],
    );
  }

  void updateFilter(String value) {
    state = state.copyWith(filter: value);
    fetchDashBoard(value);
  }

  Future<void> loadUserData() async {
    final results = await Future.wait([
      SharedPreferencesHelper.getString('name'),
      SharedPreferencesHelper.getString('email'),
      SharedPreferencesHelper.getString('phone'),
      SharedPreferencesHelper.getString('company'),
      SharedPreferencesHelper.getString('code'),
    ]);

    state = state.copyWith(
      name: results[0] ?? '',
      email: results[1] ?? '',
      phone: results[2] ?? '',
      company: results[3] ?? '',
    );

    final schoolCode = results[4];
    if (schoolCode != null && schoolCode.isNotEmpty) {
      await fetchDashBoard(state.filter);
    }
  }

  Future<void> fetchDashBoard(String filter) async {
    final schoolCode = await SharedPreferencesHelper.getString('code');
    if (schoolCode == null || schoolCode.isEmpty) return;

    state = state.copyWith(loading: true);
    try {
      final response = await _repo.fetchDashBoard(
        filter,
        schoolCode: schoolCode,
      );

      var updatedState = const HomeState();

      if (response != null) {
        for (final item in response.items) {
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
          }
        }
      }

      state = state.copyWith(
        totalPurchase: updatedState.totalPurchase,
        totalSales: updatedState.totalSales,
        expenses: updatedState.expenses,
        income: updatedState.income,
        cashInHand: updatedState.cashInHand,
        cashAtBank: updatedState.cashAtBank,
        mobileBanking: updatedState.mobileBanking,
      );
      state = state.copyWith(loading: false);
    } catch (e) {
      state = state.copyWith(loading: false);
      debugPrint('Dashboard error: $e');
    }
  }

  Future<void> logout(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    final savedPhone = sp.getString('phone');

    await sp.clear();

    if (savedPhone != null) {
      await sp.setString('phone', savedPhone);
    }

    if (!context.mounted) return;

    Navigator.pushNamedAndRemoveUntil(context, Routes.login, (_) => false);
  }
}
