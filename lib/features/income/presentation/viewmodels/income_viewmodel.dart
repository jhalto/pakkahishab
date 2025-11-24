

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/income/data/models/income_catagory_model.dart';
import 'package:pakkahishab/features/income/data/models/income_model.dart';
import 'package:pakkahishab/features/income/data/repositories/income_repository.dart';
import 'package:pakkahishab/features/sales/data/models/customer_model.dart';



final incomeViewModelProvider =
    NotifierProvider.autoDispose<IncomeNotifier, IncomeState>(
      () => IncomeNotifier(),
    );

final class IncomeState {
  // final SalesDetailsResponse? salesDetails;
  final IncomeCategoryResponse? incomeCatagory;
  final List<IncomeCategory>? filteredIncomeCatagory;
  final bool loading;
  final bool detailLoading;
  final bool hasMore;
  final int currentPage;
  final int totalPage;
  final String phone;
  final String pin;
  final String offset;
  final List<IncomeItem> incomeList;
  final String? catagoryId;
  final String? paymentMethod;
  // final String purchaseDate;
  // final String supplierId;

  const IncomeState({
    // this.salesDetails,
    this.incomeCatagory,
    this.filteredIncomeCatagory,
    this.loading = false,
    this.detailLoading = false,
    this.hasMore = false,
    this.currentPage = 1,
    this.totalPage = 0,
    this.phone = '',
    this.pin = '',
    this.offset = '0',
    this.incomeList = const [],
    this.catagoryId,
    this.paymentMethod,
  });

  IncomeState copyWith({
    // SalesDetailsResponse? salesDetails,
    IncomeCategoryResponse? incomeCatagory,
    List<IncomeCategory>? filteredIncomeCatagory,
    bool? loading,
    bool? detailLoading,
    bool? hasMore,
    int? currentPage,
    int? totalPage,
    String? phone,
    String? pin,
    String? offset,
    List<IncomeItem>? incomeList,
    String? catagoryId,
    String? paymentMethod,
  }) {
    return IncomeState(
      // salesDetails: salesDetails ?? this.salesDetails,
      incomeCatagory: incomeCatagory ?? this.incomeCatagory,
      filteredIncomeCatagory: filteredIncomeCatagory ?? this.filteredIncomeCatagory,
      loading: loading ?? this.loading,
      detailLoading: detailLoading ?? this.detailLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      phone: phone ?? this.phone,
      pin: pin ?? this.pin,
      offset: offset ?? this.offset,
      incomeList: incomeList ?? this.incomeList,
      catagoryId: catagoryId ?? this.catagoryId,
      paymentMethod: paymentMethod ?? this.paymentMethod
    );
  }
}

class IncomeNotifier extends Notifier<IncomeState> {
  late final IncomeRepository _repo;

  @override
  IncomeState build() {
    _repo = ref.read(incomeRepositoryProvider);
    fetchIncome(); // call async stuff manually
    return const IncomeState();
  }

  TextEditingController searchSupplierController = TextEditingController();
  String paymentMethod  = "Cash";

  Future<void> fetchIncome({
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

      final result = await _repo.getIncome(
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
          .map<IncomeItem>((e) => IncomeItem.fromJson(e))
          .toList();

      state = state.copyWith(
        incomeList: newItems,
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

  Future<void> updateCustomerId(String customerId) async{
    state = state.copyWith(catagoryId: customerId);
    await fetchIncome();
  }

  Future<void> refreshSales() async {
    state = state.copyWith(catagoryId: "");
    await fetchIncome();
  }

  void goToPage(int page) {
    fetchIncome(page: page);
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

  
  Future<void> getIncomeCatagory() async {
    state = state.copyWith(detailLoading: true);
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    try {
      final response = await _repo.getIncomeCatagory(
        phone: phone.toString(),
        pin: pin.toString(),
        code: code.toString(),
      );
      print(response);
      if (response['statusCode'] == 200) {
        final responseData = IncomeCategoryResponse.fromJson(response['data']);
        state = state.copyWith(
          incomeCatagory: responseData,
      filteredIncomeCatagory: responseData.items,
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

  void searchIncomeCatagory(String query) {
    final allCatagory = state.incomeCatagory?.items ?? [];

    if (query.isEmpty) {
      // if query is empty, show all suppliers
      state = state.copyWith(filteredIncomeCatagory: allCatagory);
    } else {
      final filtered = allCatagory
          .where(
            (catagory) => catagory.accountName.toLowerCase().contains(
              query.toLowerCase(),
            ),
          )
          .toList();
      state = state.copyWith(filteredIncomeCatagory: filtered);
    }
  }

   void updatePaymentMethod(String value){
    state = state.copyWith(paymentMethod: value);
   }
}
