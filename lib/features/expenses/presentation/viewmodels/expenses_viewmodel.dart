

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/expenses/data/models/expense_catagory_model.dart';
import 'package:pakkahishab/features/expenses/data/models/expenses_model.dart';
import 'package:pakkahishab/features/expenses/data/repositories/expenses_repository.dart';



// final purchaseViewModelProvider =
//     AsyncNotifierProvider<PurchaseNotifier, PurchaseState>(
//       () => PurchaseNotifier(),
//     );
final expensesViewModelProvider =
    NotifierProvider.autoDispose<ExpensesNotifier, ExpensesState>(
      () => ExpensesNotifier(),
    );

final class ExpensesState {
  // final SalesDetailsResponse? salesDetails;
  final ExpenseCategoryResponse? expenseCatagory;
  final List<ExpenseCategory>? filteredExpenseCatagory;
  final bool loading;
  final bool detailLoading;
  final bool hasMore;
  final int currentPage;
  final int totalPage;
  final String phone;
  final String pin;
  final String offset;
  final List<ExpenseItem> expensesList;
  final String? catagoryId;
  final String? paymentMethod;
  // final String purchaseDate;
  // final String supplierId;

  const ExpensesState({
    // this.salesDetails,
    this.expenseCatagory,
    this.filteredExpenseCatagory,
    this.loading = false,
    this.detailLoading = false,
    this.hasMore = false,
    this.currentPage = 1,
    this.totalPage = 0,
    this.phone = '',
    this.pin = '',
    this.offset = '0',
    this.expensesList = const [],
    this.catagoryId,
    this.paymentMethod,
  });

  ExpensesState copyWith({
    // SalesDetailsResponse? salesDetails,
    ExpenseCategoryResponse? expenseCatagory,
    List<ExpenseCategory>? filteredExpenseCatagory,
    bool? loading,
    bool? detailLoading,
    bool? hasMore,
    int? currentPage,
    int? totalPage,
    String? phone,
    String? pin,
    String? offset,
    List<ExpenseItem>? expensesList,
    String? catagoryId,
    String? paymentMethod,
  }) {
    return ExpensesState(
      // salesDetails: salesDetails ?? this.salesDetails,
      expenseCatagory: expenseCatagory ?? this.expenseCatagory,
      filteredExpenseCatagory: filteredExpenseCatagory ?? this.filteredExpenseCatagory,
      loading: loading ?? this.loading,
      detailLoading: detailLoading ?? this.detailLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      phone: phone ?? this.phone,
      pin: pin ?? this.pin,
      offset: offset ?? this.offset,
      expensesList: expensesList ?? this.expensesList,
      catagoryId: catagoryId ?? this.catagoryId,
      paymentMethod: paymentMethod ?? this.paymentMethod
    );
  }
}

class ExpensesNotifier extends Notifier<ExpensesState> {
  late final ExpensesRepository _repo;

  @override
  ExpensesState build() {
    _repo = ref.read(expensesRepositoryProvider);
    fetchExpenses(); // call async stuff manually
    return const ExpensesState();
  }

  TextEditingController searchSupplierController = TextEditingController();
 

  Future<void> fetchExpenses({
    bool loadMore = false,
    int? page,
    String? voucherDate,
  }) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    try {
      state = state.copyWith(loading: true);

      // if user taps a page number, use that page’s offset
      final int newPage = page ?? (loadMore ? state.currentPage + 1 : 1);
      final int newOffset = (newPage - 1) * 10;

      final result = await _repo.getExpenses(
        phone: phone ?? '',
        pin: pin ?? '',
        code: code ?? '',
        offset: newOffset.toString(),
        voucherDate: voucherDate,
        catagoryId: state.catagoryId,
      );

      final items = (result['data']['items'] ?? []) as List;
      final hasMore = result['data']['hasMore'] ?? false;
      final totalItem = result['data']['count'] ?? 0;
      print(totalItem);
      state = state.copyWith(totalPage: (totalItem / 10).ceil());
      print(state.totalPage);
      final newItems = items
          .map<ExpenseItem>((e) => ExpenseItem.fromJson(e))
          .toList();

      state = state.copyWith(
        expensesList: newItems,
        offset: newOffset.toString(),
        currentPage: newPage,
        hasMore: hasMore,
      );
    } catch (e) {
      debugPrint("Error fetching purchases: $e");
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> updateCatagoryId(String catagoryId) async{
    state = state.copyWith(catagoryId: catagoryId);
   await fetchExpenses();
  }
  Future<void> refreshSales() async {
    state = state.copyWith(catagoryId: "");
    await fetchExpenses();
  }

  void goToPage(int page) {
    fetchExpenses(page: page);
  }

  // void refreshPurchases() {
  //   state = const PurchaseState();
  //   fetchPurchases();
  // }

  // Future<bool> fetchSalesDetails({
  //   bool loadMore = false,
  //   int? page,
  //   required String saleNo,
  // }) async {
  //   final phone = await SharedPreferencesHelper.getString('phone');
  //   final pin = await SharedPreferencesHelper.getString('pin');
  //   final code = await SharedPreferencesHelper.getString('code');

  //   try {
  //     state = state.copyWith(detailLoading: true);

  //     final int newPage = page ?? (loadMore ? state.currentPage + 1 : 1);
  //     final int newOffset = (newPage - 1) * 10;

  //     final response = await _repo.getSaleDetails(
  //       phone: phone ?? '',
  //       pin: pin ??"",
  //       code: code ?? '',
  //       offset: newOffset.toString(),
  //       saleNo: saleNo,
  //     );

  //     if (response['statusCode'] == 200) {
  //       final salesData = SalesDetailsResponse.fromJson(response['data']);
  //       state = state.copyWith(salesDetails: salesData);
  //       return true; // ✅ signal success
  //     }
  //   } catch (e) {
  //     debugPrint("Error fetching purchases: $e");
  //   } finally {
  //     state = state.copyWith(detailLoading: false);
  //   }
  //   return false;
  // }

  
  Future<void> getExpenseCatagory() async {
    state = state.copyWith(detailLoading: true);
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    try {
      final response = await _repo.getExpenseCatagory(
        phone: phone.toString(),
        pin: pin.toString(),
        code: code.toString(),
      );
      print(response);
      if (response['statusCode'] == 200) {
        final responseData = ExpenseCategoryResponse.fromJson(response['data']);
        state = state.copyWith(
          expenseCatagory: responseData,
          filteredExpenseCatagory: responseData.items,
        );
        print("done");
      } else {
        print("error $response");
      }
    } catch (e) {
      print(e);
    } finally {
      state = state.copyWith(detailLoading: false);
    }
  }

  void searchExpenseCatagory(String query) {
    final allCatagory = state.expenseCatagory?.items ?? [];

    if (query.isEmpty) {
      // if query is empty, show all suppliers
      state = state.copyWith(filteredExpenseCatagory: allCatagory);
    } else {
      final filtered = allCatagory
          .where(
            (catagory) => catagory.accountName.toLowerCase().contains(
              query.toLowerCase(),
            ),
          )
          .toList();
      state = state.copyWith(filteredExpenseCatagory: filtered);
    }
  }

   void updatePaymentMethod(String value){
    state = state.copyWith(paymentMethod: value);
   }
}
