import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/advance/data/models/advance_head_model.dart';
import 'package:pakkahishab/features/advance/data/models/advance_model.dart';
import 'package:pakkahishab/features/advance/data/repositories/advance_repository.dart';






import 'package:pakkahishab/features/stock/data/models/stock_product_model.dart';


final advanceViewModelProvider =
    NotifierProvider.autoDispose<AdvanceNotifier, AdvanceState>(
      () => AdvanceNotifier(),
    );

final class AdvanceState {
  // final SalesDetailsResponse? salesDetails;
  final AdvanceHeadResponse? advanceHeadResponse;
  final List<AdvanceHeadItem>? filteredAdvanceHeadItem;
  final bool loading;
  final bool detailLoading;
  final bool hasMore;
  final int currentPage;
  final int totalPage;
  final String phone;
  final String pin;
  final String offset;
  final List<AdvanceItem> advanceList;
  final String? productId;
  final String? paymentMethod;
  // final String purchaseDate;
  // final String supplierId;

  const AdvanceState({
    // this.salesDetails,
    this.advanceHeadResponse,
    this.filteredAdvanceHeadItem,
    this.loading = false,
    this.detailLoading = false,
    this.hasMore = false,
    this.currentPage = 1,
    this.totalPage = 0,
    this.phone = '',
    this.pin = '',
    this.offset = '0',
    this.advanceList = const [],
    this.productId,
    this.paymentMethod,
  });

  AdvanceState copyWith({
    // SalesDetailsResponse? salesDetails,
    AdvanceHeadResponse? advanceHeadResponse,
    List<AdvanceHeadItem>? filteredAdvanceHeadItem,
    bool? loading,
    bool? detailLoading,
    bool? hasMore,
    int? currentPage,
    int? totalPage,
    String? phone,
    String? pin,
    String? offset,
    List<AdvanceItem>? advanceList,
    String? productId,
    String? paymentMethod,
  }) {
    return AdvanceState(
      // salesDetails: salesDetails ?? this.salesDetails,
      advanceHeadResponse: advanceHeadResponse ?? this.advanceHeadResponse,
      filteredAdvanceHeadItem:
          filteredAdvanceHeadItem ?? this.filteredAdvanceHeadItem,
      loading: loading ?? this.loading,
      detailLoading: detailLoading ?? this.detailLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      phone: phone ?? this.phone,
      pin: pin ?? this.pin,
      offset: offset ?? this.offset,
      advanceList: advanceList ?? this.advanceList,
      productId: productId ?? this.productId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}

class AdvanceNotifier extends Notifier<AdvanceState> {
  late final AdvanceRepository _repo;

  @override
  AdvanceState build() {
    _repo = ref.read(advanceRepositoryProvider);
    fetchBankAmountItem(); // call async stuff manually
    return const AdvanceState();
  }

  TextEditingController searchSupplierController = TextEditingController();
  String paymentMethod = "Cash";

  Future<void> fetchBankAmountItem({
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

      final result = await _repo.getBankAmountItem(
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
          .map<AdvanceItem>((e) => AdvanceItem.fromJson(e))
          .toList();

      state = state.copyWith(
        advanceList: newItems,
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
    await fetchBankAmountItem();
  }

  Future<void> refreshSales() async {
    state = state.copyWith(productId: "");
    await fetchBankAmountItem();
  }

  void goToPage(int page) {
    fetchBankAmountItem(page: page);
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

  Future<void> getAdvanceHead() async {
    state = state.copyWith(detailLoading: true);
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    try {
      final response = await _repo.getAdvanceHead(
        phone: phone.toString(),
        pin: pin.toString(),
        code: code.toString(),
      );
      print(response);
      if (response['statusCode'] == 200) {
        final responseData = AdvanceHeadResponse.fromJson(
          response['data'],
        );
        state = state.copyWith(
          advanceHeadResponse: responseData,
          filteredAdvanceHeadItem: responseData.items,
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

  void searchAdvanceHeadItem(String query) {
    final allCatagory = state.advanceHeadResponse?.items ?? [];

    if (query.isEmpty) {
      // if query is empty, show all suppliers
      state = state.copyWith(filteredAdvanceHeadItem: allCatagory);
    } else {
      final filtered = allCatagory
          .where(
            (catagory) => (catagory.accountName?.toLowerCase().contains(
              query.toLowerCase(),
            )) ?? false,
          )
          .toList();
      state = state.copyWith(filteredAdvanceHeadItem: filtered);
    }
  }

  void updatePaymentMethod(String value) {
    state = state.copyWith(paymentMethod: value);
  }
}
