

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/due/data/models/due_model.dart';
import 'package:pakkahishab/features/due/data/repositories/supplier_due_repository.dart';
import 'package:pakkahishab/features/purchase/data/models/purchase_detail_model.dart';
import 'package:pakkahishab/features/purchase/data/models/purchase_model.dart';
import 'package:pakkahishab/features/purchase/data/models/supplier_model.dart';
import 'package:pakkahishab/features/purchase/data/repositories/purchase_repository.dart';


final supplierDueViewModelProvider =
    NotifierProvider.autoDispose<SupplierDuesNotifier, SupplierDueState>(
      () => SupplierDuesNotifier(),
    );

final class SupplierDueState {
  final PurchaseDetailsResponse? purchaseDetails;
  final SupplierResponse? supplier;
  final List<Supplier>? filteredSuppliers;
  final bool loading;
  final bool detailLoading;
  final bool hasMore;
  final int currentPage;
  final int totalPage;
  final String phone;
  final String pin;
  final String offset;
  final List<DueItem> duesList;
  final String? supplierId;
  final String? paymentMethod;
  // final String purchaseDate;
  // final String supplierId;

  const SupplierDueState({
    this.purchaseDetails,
    this.supplier,
    this.filteredSuppliers,
    this.loading = false,
    this.detailLoading = false,
    this.hasMore = false,
    this.currentPage = 1,
    this.totalPage = 0,
    this.phone = '',
    this.pin = '',
    this.offset = '0',
    this.duesList = const [],
    this.supplierId,
    this.paymentMethod,
  });

  SupplierDueState copyWith({
    PurchaseDetailsResponse? purchaseDetails,
    SupplierResponse? supplier,
    List<Supplier>? filteredSuppliers,
    bool? loading,
    bool? detailLoading,
    bool? hasMore,
    int? currentPage,
    int? totalPage,
    String? phone,
    String? pin,
    String? offset,
    List<DueItem>? duesList,
    String? supplierId,
    String? paymentMethod,
  }) {
    return SupplierDueState(
      purchaseDetails: purchaseDetails ?? this.purchaseDetails,
      supplier: supplier ?? this.supplier,
      filteredSuppliers: filteredSuppliers ?? this.filteredSuppliers,
      loading: loading ?? this.loading,
      detailLoading: detailLoading ?? this.detailLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      phone: phone ?? this.phone,
      pin: pin ?? this.pin,
      offset: offset ?? this.offset,
      duesList: duesList ?? this.duesList,
      supplierId: supplierId ?? this.supplierId,
      paymentMethod: paymentMethod ?? this.paymentMethod
    );
  }
}

class SupplierDuesNotifier extends Notifier<SupplierDueState> {
  late final SupplierDueRepository _repo;

  @override
  SupplierDueState build() {
    _repo = ref.read(supplierDueRepositoryProvider);
    fetchSupplierDues(); // call async stuff manually
    return const SupplierDueState();
  }

  TextEditingController searchSupplierController = TextEditingController();
  String paymentMethod  = "Cash";

  Future<void> fetchSupplierDues({
    bool loadMore = false,
    int? page,
    String? dueDate,
  }) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    try {
      state = state.copyWith(loading: true);

      // if user taps a page number, use that page’s offset
      final int newPage = page ?? (loadMore ? state.currentPage + 1 : 1);
      final int newOffset = (newPage - 1) * 10;

      final result = await _repo.getSupplierDues(
        phone: phone ?? '',
        pin: pin ?? '',
        code: code ?? '',
        offset: newOffset.toString(),
        dueDate: dueDate,
        supplierId: state.supplierId,
      );

      final items = (result['data']['items'] ?? []) as List;
      final hasMore = result['data']['hasMore'] ?? false;
      final totalItem = result['data']['items'][0]['total_count'] ?? 0;
      print(totalItem);
      state = state.copyWith(totalPage: (totalItem / 10).ceil());
      print(state.totalPage);
      final newItems = items
          .map<DueItem>((e) => DueItem.fromJson(e))
          .toList();

      state = state.copyWith(
        duesList: newItems,
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

  void updateSupplierId(String supplierId) {
    state = state.copyWith(supplierId: supplierId);
  }

  Future<void> refreshPurchases() async {
    state = state.copyWith(supplierId: "");
    await fetchSupplierDues();
  }

  void goToPage(int page) {
    fetchSupplierDues(page: page);
  }

  // void refreshPurchases() {
  //   state = const PurchaseState();
  //   fetchPurchases();
  // }

  Future<bool> fetchPurchaseDetails({
    bool loadMore = false,
    int? page,
    required String purchaseNo,
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
        purchaseNo: purchaseNo,
      );

      if (response['statusCode'] == 200) {
        final purchaseData = PurchaseDetailsResponse.fromJson(response['data']);
        state = state.copyWith(purchaseDetails: purchaseData);
        return true; // ✅ signal success
      }
    } catch (e) {
      debugPrint("Error fetching purchases: $e");
    } finally {
      state = state.copyWith(detailLoading: false);
    }
    return false;
  }

  // bool supplierLoading = false;

  Future<void> getSupplier() async {
    state = state.copyWith(detailLoading: true);
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    try {
      final response = await _repo.getSupplier(
        phone: phone.toString(),
        pin: pin.toString(),
        code: code.toString(),
      );
      
      print(code.toString());
      if (response['statusCode'] == 200) {
        final responseData = SupplierResponse.fromJson(response['data']);
        state = state.copyWith(
          supplier: responseData,
          filteredSuppliers: responseData.items,
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
    final allSuppliers = state.supplier?.items ?? [];

    if (query.isEmpty) {
      // if query is empty, show all suppliers
      state = state.copyWith(filteredSuppliers: allSuppliers);
    } else {
      final filtered = allSuppliers
          .where(
            (supplier) => supplier.supplierName.toLowerCase().contains(
              query.toLowerCase(),
            ),
          )
          .toList();
      state = state.copyWith(filteredSuppliers: filtered);
    }
  }

   void updatePaymentMethod(String value){
    state = state.copyWith(paymentMethod: value);
   }
}
