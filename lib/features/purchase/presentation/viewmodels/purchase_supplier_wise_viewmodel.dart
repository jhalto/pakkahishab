import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/purchase/data/models/supplier_model.dart';
import 'package:pakkahishab/features/purchase/data/models/supplier_wise_purchase_model.dart';
import 'package:pakkahishab/features/purchase/data/repositories/purchase_repository.dart';

final purchaseSupplierWiseViewModel =
    NotifierProvider.autoDispose<
      PurchaseWiseSupplierNotifier,
      PurchaseWiseSupplierState
    >(() => PurchaseWiseSupplierNotifier());

final class PurchaseWiseSupplierState {
  final bool loading;
  final bool supplierLoading;
  final bool hasMore;
  final int currentPage;
  final int totalPage;
  final int offset;
  final String? supplierId;
  final String? totalPurchase;
  final SupplierResponse? supplier;
  final List<Supplier>? filteredSuppliers;
  final List<SupplierPurchaseItem> supplierPurchaseList;

  const PurchaseWiseSupplierState({
    this.loading = false,
    this.supplierLoading = false,
    this.hasMore = false,
    this.currentPage = 1,
    this.totalPage = 1,
    this.offset = 0,
    this.supplierId,
    this.totalPurchase,
    this.supplier,
    this.filteredSuppliers,
    this.supplierPurchaseList = const [],
  });

  PurchaseWiseSupplierState copyWith({
    bool? loading,
    bool? supplierLoading,
    bool? hasMore,
    int? currentPage,
    int? totalPage,
    int? offset,
    String? supplierId,
    String? totalPurchase,
    SupplierResponse? supplier,
    List<Supplier>? filteredSuppliers,
    List<SupplierPurchaseItem>? supplierPurchaseList,
  }) {
    return PurchaseWiseSupplierState(
      loading: loading ?? this.loading,
      supplierLoading: supplierLoading ?? this.supplierLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      offset: offset ?? this.offset,
      supplierId: supplierId ?? this.supplierId,
      totalPurchase: totalPurchase ?? this.totalPurchase,
      supplier: supplier ?? this.supplier,
      filteredSuppliers: filteredSuppliers ?? this.filteredSuppliers,
      supplierPurchaseList: supplierPurchaseList ?? this.supplierPurchaseList,
    );
  }
}

final class PurchaseWiseSupplierNotifier
    extends Notifier<PurchaseWiseSupplierState> {
  late PurchaseRepository _repo;

  @override
  build() {
    _repo = ref.read(purchaseRepositoryProvider);
    ref.onDispose(() {
      searchSupplierController.dispose();
    });
     Future.microtask(fetchSupplierWisePurchases);
    return PurchaseWiseSupplierState();
  }

  // Supplier search controller for filter

  TextEditingController searchSupplierController = TextEditingController();

  // Api Call

  Future<void> fetchSupplierWisePurchases({
    bool loadMore = false,
    int? page,
    String? purchaseDate,
  }) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SecureStorageHelper.getString('pin');
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
      final totalItem = result['data']['items'][0]['total_supplier_count'] ?? 0;
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
      if (!ref.mounted) return;
      state = state.copyWith(
        supplierPurchaseList: newItems,
        offset: newOffset,
        currentPage: newPage,
        hasMore: hasMore,
        totalPage: (totalItem / 10).ceil(),
        totalPurchase: totalPrice.toString(),
      );
    } catch (e) {
      debugPrint("Error fetching purchases: $e");
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> refreshSupplierWisePurchases() async {
    state = state.copyWith(supplierId: "");
    await fetchSupplierWisePurchases();
  }

  void updateSupplierId(String supplierId) async {
    state = state.copyWith(supplierId: supplierId);

    fetchSupplierWisePurchases();
  }

  void goToPage(int page) async {
    await fetchSupplierWisePurchases(page: page);
  }

  Future<void> getSupplier() async {
    state = state.copyWith(supplierLoading: true);
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
      state = state.copyWith(supplierLoading: false);
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
}
