import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/core/utils/show_snackbar.dart';
import 'package:pakkahishab/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:pakkahishab/features/purchase/data/models/purchase_detail_model.dart';
import 'package:pakkahishab/features/purchase/data/models/purchase_model.dart';
import 'package:pakkahishab/features/purchase/data/models/supplier_model.dart';
import 'package:pakkahishab/features/purchase/data/models/supplier_wise_purchase_model.dart';
import 'package:pakkahishab/features/purchase/data/repositories/purchase_repository.dart';

final purchaseViewModelProvider =
    NotifierProvider.autoDispose<PurchaseNotifier, PurchaseState>(
      () => PurchaseNotifier(),
    );

final class PurchaseState {
  final PurchaseDetailsResponse? purchaseDetails;
  final SupplierResponse? supplier;
  final List<Supplier>? filteredSuppliers;
  final bool loading;
  final bool detailLoading;
  final bool hasMore;
  final int currentPage;
  final int totalPage;
  final int mainTotalPage;
  final String phone;
  final String pin;
  final String offset;
  final String offset1;
  final List<PurchaseItem> purchaseList;
  final List<SupplierPurchaseItem> supplierPurchaseList;
  final String? supplierId;
  final String? paymentMethod;
  final String? totalPurchase;
  // final String purchaseDate;
  // final String supplierId;

  const PurchaseState({
    this.purchaseDetails,
    this.supplier,
    this.filteredSuppliers,
    this.loading = false,
    this.detailLoading = false,
    this.hasMore = false,
    this.currentPage = 1,
    this.totalPage = 0,
    this.mainTotalPage = 0,
    this.phone = '',
    this.pin = '',
    this.offset = '0',
    this.offset1 = '0',
    this.purchaseList = const [],
    this.supplierPurchaseList = const [],
    this.supplierId,
    this.paymentMethod,
    this.totalPurchase,
  });

  PurchaseState copyWith({
    PurchaseDetailsResponse? purchaseDetails,
    SupplierResponse? supplier,
    List<Supplier>? filteredSuppliers,
    bool? loading,
    bool? detailLoading,
    bool? hasMore,
    int? currentPage,
    int? totalPage,
    int? mainTotalPage,
    String? phone,
    String? pin,
    String? offset,
    String? offset1,
    List<PurchaseItem>? purchaseList,
    List<SupplierPurchaseItem>? supplierPurchaseList,
    String? supplierId,
    String? paymentMethod,
    String? totalPurchase,
  }) {
    return PurchaseState(
      purchaseDetails: purchaseDetails ?? this.purchaseDetails,
      supplier: supplier ?? this.supplier,
      filteredSuppliers: filteredSuppliers ?? this.filteredSuppliers,
      loading: loading ?? this.loading,
      detailLoading: detailLoading ?? this.detailLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      mainTotalPage: mainTotalPage ?? this.mainTotalPage,
      phone: phone ?? this.phone,
      pin: pin ?? this.pin,
      offset: offset ?? this.offset,
      offset1: offset ?? this.offset1,
      purchaseList: purchaseList ?? this.purchaseList,
      supplierPurchaseList: supplierPurchaseList ?? this.supplierPurchaseList,
      supplierId: supplierId ?? this.supplierId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalPurchase: totalPurchase ?? this.totalPurchase,
    );
  }
}

class PurchaseNotifier extends Notifier<PurchaseState> {
  late final PurchaseRepository _repo;

  @override
  PurchaseState build() {
    _repo = ref.read(purchaseRepositoryProvider);
    // fetchPurchases(); // call async stuff manually
    fetchSupplierWisePurchases();
    return const PurchaseState();
  }

  TextEditingController searchSupplierController = TextEditingController();
  String paymentMethod = "Cash";

  Future<void> fetchPurchases({
    bool loadMore = false,
    int? page,
    String? purchaseDate,
  }) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    try {
      state = state.copyWith(loading: true);

      // if user taps a page number, use that page’s offset
      final int newPage = page ?? (loadMore ? state.currentPage + 1 : 1);
      final int newOffset = (newPage - 1) * 10;

      final result = await _repo.getPurchases(
        phone: phone ?? '',
        pin: pin ?? '',
        code: code ?? '',
        offset: newOffset.toString(),
        purchaseDate: purchaseDate,
        supplierId: state.supplierId,
      );

      final items = (result['data']['items'] ?? []) as List;
      final hasMore = result['data']['hasMore'] ?? false;
      final totalItem = result['data']['items'][0]['total_count'] ?? 0;
      print(totalItem);
      print(state.totalPage);
      final newItems = items
          .map<PurchaseItem>((e) => PurchaseItem.fromJson(e))
          .toList();

      state = state.copyWith(
        purchaseList: newItems,
        offset: newOffset.toString(),
        currentPage: newPage,
        hasMore: hasMore,
        totalPage: (totalItem / 10).ceil(),
      );
    } catch (e) {
      debugPrint("Error fetching purchases: $e");
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> fetchSupplierWisePurchases({
    bool loadMore = false,
    int? page,
    String? purchaseDate,
  }) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    try {
      state = state.copyWith(loading: true);

      // if user taps a page number, use that page’s offset
      final int newPage = page ?? (loadMore ? state.currentPage + 1 : 1);
      final int newOffset = (newPage - 1) * 10;

      final result = await _repo.getSupplierWisePurchases(
        phone: phone ?? '',
        pin: pin ?? '',
        code: code ?? '',
        offset: newOffset.toString(),
        supplierId: state.supplierId,
      );

      final items = (result['data']['items'] ?? []) as List;
      final hasMore = result['data']['hasMore'] ?? false;
      final totalItem = result['data']['count'] ?? 0;
      double totalPrice = 0.0;
      if (totalItem > 0) {
        totalPrice = items.fold<double>(
          0,
          (sum, item) => sum + (item['total_purchase_amount'] ?? 0).toDouble(),
        );
      }

      final newItems = items
          .map<SupplierPurchaseItem>((e) => SupplierPurchaseItem.fromJson(e))
          .toList();

      state = state.copyWith(
        supplierPurchaseList: newItems,
        offset: newOffset.toString(),
        currentPage: newPage,
        hasMore: hasMore,
        mainTotalPage: (totalItem / 10).ceil(),
        totalPurchase: totalPrice.toString(),
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
    await fetchPurchases();
  }

  void goToPage(int page) {
    fetchPurchases(page: page);
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

      final response = await _repo.getPurchaseDetails(
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

  void updatePaymentMethod(String value) {
    state = state.copyWith(paymentMethod: value);
  }

  Future<void> deletePurchase(
    BuildContext context, {
    required String purchaseId,
  }) async {
    state = state.copyWith(loading: true);
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    print(purchaseId);
    print(phone);
    print(pin);
    print(code);

    final response = await _repo.deletePurchase(
      phone: phone.toString(),
      pin: pin.toString(),
      code: code.toString(),
      purchaseId: purchaseId,
    );

    if (response['status'] == 'success') {
      await fetchPurchases();
      fetchSupplierWisePurchases();
      ref.read(homeProvider.notifier).fetchDashBoard('All');
      state = state.copyWith(loading: false);
      if (!context.mounted) return;
      showCustomSnackBar(
        context,
        "Purchase deleted successfully",
        type: SnackBarType.success,
      );
    } else {
      state = state.copyWith(loading: false);
      if (!context.mounted) return;
      showCustomSnackBar(context, response['message']);
    }
  }
}
