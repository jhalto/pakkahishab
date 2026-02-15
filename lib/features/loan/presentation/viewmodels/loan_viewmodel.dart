import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/loan/data/models/loan_model.dart';
import 'package:pakkahishab/features/loan/data/repositories/loan_repository.dart';

import 'package:pakkahishab/features/stock/data/models/stock_product_model.dart';

final loanViewModelProvider =
    NotifierProvider.autoDispose<LoanNotifier, LoanState>(() => LoanNotifier());

final class LoanState {
  // final SalesDetailsResponse? salesDetails;
  final StockProductNameResponse? stockProductName;
  final List<StockProductItem>? filteredStockProductItem;
  final bool loading;
  final bool detailLoading;
  final bool hasMore;
  final int currentPage;
  final int totalPage;
  final String phone;
  final String pin;
  final String offset;
  final List<LoanItem> loanList;
  final String? productId;
  final String? paymentMethod;
  // final String purchaseDate;
  // final String supplierId;

  const LoanState({
    // this.salesDetails,
    this.stockProductName,
    this.filteredStockProductItem,
    this.loading = false,
    this.detailLoading = false,
    this.hasMore = false,
    this.currentPage = 1,
    this.totalPage = 0,
    this.phone = '',
    this.pin = '',
    this.offset = '0',
    this.loanList = const [],
    this.productId,
    this.paymentMethod,
  });

  LoanState copyWith({
    // SalesDetailsResponse? salesDetails,
    StockProductNameResponse? stockProductName,
    List<StockProductItem>? filteredStockProductItem,
    bool? loading,
    bool? detailLoading,
    bool? hasMore,
    int? currentPage,
    int? totalPage,
    String? phone,
    String? pin,
    String? offset,
    List<LoanItem>? loanList,
    String? productId,
    String? paymentMethod,
  }) {
    return LoanState(
      // salesDetails: salesDetails ?? this.salesDetails,
      stockProductName: stockProductName ?? this.stockProductName,
      filteredStockProductItem:
          filteredStockProductItem ?? this.filteredStockProductItem,
      loading: loading ?? this.loading,
      detailLoading: detailLoading ?? this.detailLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      phone: phone ?? this.phone,
      pin: pin ?? this.pin,
      offset: offset ?? this.offset,
      loanList: loanList ?? this.loanList,
      productId: productId ?? this.productId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}

class LoanNotifier extends Notifier<LoanState> {
  late final LoanRepository _repo;

  @override
  LoanState build() {
    _repo = ref.read(loanRepositoryProvider);
    fetchLoanItem(); // call async stuff manually
    return const LoanState();
  }

  TextEditingController searchSupplierController = TextEditingController();
  String paymentMethod = "Cash";

  Future<void> fetchLoanItem({
    bool loadMore = false,
    int? page,
    String? productId,
  }) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    try {
      state = state.copyWith(loading: true);

      // if user taps a page number, use that page’s offset
      final int newPage = page ?? (loadMore ? state.currentPage + 1 : 1);
      final int newOffset = (newPage - 1) * 10;

      final result = await _repo.getLoanItem(
        phone: phone ?? '',
        pin: pin ?? '',
        code: code ?? '',
        offset: newOffset.toString(),
        productId: state.productId,
      );

      final items = (result['data']['items'] ?? []) as List;
      final hasMore = result['data']['hasMore'] ?? false;
      final totalItem = result['data']['count'] ?? 0;
      print(totalItem);
      state = state.copyWith(totalPage: (totalItem / 10).ceil());
      print(state.totalPage);
      final newItems = items
          .map<LoanItem>((e) => LoanItem.fromJson(e))
          .toList();

      state = state.copyWith(
        loanList: newItems,
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

  Future<void> updateProductId({required String productId}) async {
    state = state.copyWith(productId: productId);
    await fetchLoanItem();
  }

  Future<void> refreshSales() async {
    state = state.copyWith(productId: "");
    await fetchLoanItem();
  }

  void goToPage(int page) {
    fetchLoanItem(page: page);
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

  Future<void> getStockProductName() async {
    state = state.copyWith(detailLoading: true);
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    try {
      final response = await _repo.getStockProductName(
        phone: phone.toString(),
        pin: pin.toString(),
        code: code.toString(),
      );
      if (kDebugMode) {
        print(response);
      }
      if (response['statusCode'] == 200) {
        final responseData = StockProductNameResponse.fromJson(
          response['data'],
        );
        state = state.copyWith(
          stockProductName: responseData,
          filteredStockProductItem: responseData.items,
        );
        if (kDebugMode) {
          print("done");
        }
      } else {
        if (kDebugMode) {
          print("error $response");
        }
      }
    } catch (e) {
      print(e);
    } finally {
      state = state.copyWith(detailLoading: false);
    }
  }

  void searchStockProdutItem(String query) {
    final allCatagory = state.stockProductName?.items ?? [];

    if (query.isEmpty) {
      // if query is empty, show all suppliers
      state = state.copyWith(filteredStockProductItem: allCatagory);
    } else {
      final filtered = allCatagory
          .where(
            (catagory) => catagory.productName.toLowerCase().contains(
              query.toLowerCase(),
            ),
          )
          .toList();
      state = state.copyWith(filteredStockProductItem: filtered);
    }
  }

  void updatePaymentMethod(String value) {
    state = state.copyWith(paymentMethod: value);
  }
}
