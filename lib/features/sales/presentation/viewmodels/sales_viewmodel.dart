

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/sales/data/models/customer_model.dart';
import 'package:pakkahishab/features/sales/data/models/sale_details_model.dart';
import 'package:pakkahishab/features/sales/data/models/sales_model.dart';
import 'package:pakkahishab/features/sales/data/repositories/sales_repository.dart';

// final purchaseViewModelProvider =
//     AsyncNotifierProvider<PurchaseNotifier, PurchaseState>(
//       () => PurchaseNotifier(),
//     );
final salesViewModelProvider =
    NotifierProvider.autoDispose<SalesNotifier, SalesState>(
      () => SalesNotifier(),
    );

final class SalesState {
  final SalesDetailsResponse? salesDetails;
  final CustomerResponse? customer;
  final List<Customer>? filteredCustomers;
  final bool loading;
  final bool detailLoading;
  final bool hasMore;
  final int currentPage;
  final int totalPage;
  final String phone;
  final String pin;
  final String offset;
  final List<SalesItem> salesList;
  final String? customerId;
  final String? paymentMethod;
  // final String purchaseDate;
  // final String supplierId;

  const SalesState({
    this.salesDetails,
    this.customer,
    this.filteredCustomers,
    this.loading = false,
    this.detailLoading = false,
    this.hasMore = false,
    this.currentPage = 1,
    this.totalPage = 0,
    this.phone = '',
    this.pin = '',
    this.offset = '0',
    this.salesList = const [],
    this.customerId,
    this.paymentMethod,
  });

  SalesState copyWith({
    SalesDetailsResponse? salesDetails,
    CustomerResponse? customer,
    List<Customer>? filteredCustomers,
    bool? loading,
    bool? detailLoading,
    bool? hasMore,
    int? currentPage,
    int? totalPage,
    String? phone,
    String? pin,
    String? offset,
    List<SalesItem>? salesList,
    String? customerId,
    String? paymentMethod,
  }) {
    return SalesState(
      salesDetails: salesDetails ?? this.salesDetails,
      customer: customer ?? this.customer,
      filteredCustomers: filteredCustomers ?? this.filteredCustomers,
      loading: loading ?? this.loading,
      detailLoading: detailLoading ?? this.detailLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      phone: phone ?? this.phone,
      pin: pin ?? this.pin,
      offset: offset ?? this.offset,
      salesList: salesList ?? this.salesList,
      customerId: customerId ?? this.customerId,
      paymentMethod: paymentMethod ?? this.paymentMethod
    );
  }
}

class SalesNotifier extends Notifier<SalesState> {
  late final SalesRepository _repo;

  @override
  SalesState build() {
    _repo = ref.read(salesRepositoryProvider);
    fetchSales(); // call async stuff manually
    return const SalesState();
  }

  TextEditingController searchSupplierController = TextEditingController();
  String paymentMethod  = "Cash";

  Future<void> fetchSales({
    bool loadMore = false,
    int? page,
    String? saleDate,
  }) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    try {
      state = state.copyWith(loading: true);

      // if user taps a page number, use that page’s offset
      final int newPage = page ?? (loadMore ? state.currentPage + 1 : 1);
      final int newOffset = (newPage - 1) * 10;

      final result = await _repo.getSales(
        phone: phone ?? '',
        pin: pin ?? '',
        code: code ?? '',
        offset: newOffset.toString(),
        saleDate: saleDate,
        customerId: state.customerId,
      );

      final items = (result['data']['items'] ?? []) as List;
      final hasMore = result['data']['hasMore'] ?? false;
      final totalItem = result['data']['items'][0]['total_count'] ?? 0;
      print(totalItem);
      state = state.copyWith(totalPage: (totalItem / 10).ceil());
      print(state.totalPage);
      final newItems = items
          .map<SalesItem>((e) => SalesItem.fromJson(e))
          .toList();

      state = state.copyWith(
        salesList: newItems,
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

  void updateCustomerId(String customerId) {
    state = state.copyWith(customerId: customerId);
  }

  Future<void> refreshSales() async {
    state = state.copyWith(customerId: "");
    await fetchSales();
  }

  void goToPage(int page) {
    fetchSales(page: page);
  }

  // void refreshPurchases() {
  //   state = const PurchaseState();
  //   fetchPurchases();
  // }

  Future<bool> fetchSalesDetails({
    bool loadMore = false,
    int? page,
    required String saleNo,
  }) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin') ?? '';
    final code = await SharedPreferencesHelper.getString('code');

    try {
      state = state.copyWith(detailLoading: true);

      final int newPage = page ?? (loadMore ? state.currentPage + 1 : 1);
      final int newOffset = (newPage - 1) * 10;

      final response = await _repo.getSaleDetails(
        phone: phone ?? '',
        pin: pin,
        code: code ?? '',
        offset: newOffset.toString(),
        saleNo: saleNo,
      );

      if (response['statusCode'] == 200) {
        final salesData = SalesDetailsResponse.fromJson(response['data']);
        state = state.copyWith(salesDetails: salesData);
        return true; // ✅ signal success
      }
    } catch (e) {
      debugPrint("Error fetching purchases: $e");
    } finally {
      state = state.copyWith(detailLoading: false);
    }
    return false;
  }

  
  Future<void> getCustomer() async {
    state = state.copyWith(detailLoading: true);
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    try {
      final response = await _repo.getCustomer(
        phone: phone.toString(),
        pin: pin.toString(),
        code: code.toString(),
      );
      print(response);
      if (response['statusCode'] == 200) {
        final responseData = CustomerResponse.fromJson(response['data']);
        state = state.copyWith(
          customer: responseData,
          filteredCustomers: responseData.items,
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

  void searchSupplier(String query) {
    final allCustomers = state.customer?.items ?? [];

    if (query.isEmpty) {
      // if query is empty, show all suppliers
      state = state.copyWith(filteredCustomers: allCustomers);
    } else {
      final filtered = allCustomers
          .where(
            (supplier) => supplier.customerName.toLowerCase().contains(
              query.toLowerCase(),
            ),
          )
          .toList();
      state = state.copyWith(filteredCustomers: filtered);
    }
  }

   void updatePaymentMethod(String value){
    state = state.copyWith(paymentMethod: value);
   }
}
