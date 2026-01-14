import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/purchase/data/models/supplier_wise_purchase_model.dart';
import 'package:pakkahishab/features/purchase/data/repositories/purchase_repository.dart';

final purchaseWiseSupplierViewModel =
    NotifierProvider<PurchaseWiseSupplierNotifier, PurchaseWiseSupplierState>(
      () => PurchaseWiseSupplierNotifier(),
    );

final class PurchaseWiseSupplierState {
  final bool loading;
  final bool hasMore;
  final int currentPage;
  final int totalPage;
  final int offset;
  final String? supplierId;
  final List<SupplierPurchaseItem> supplierPurchaseList;

  const PurchaseWiseSupplierState({
    this.loading = false,
    this.hasMore = false,
    this.currentPage = 1,
    this.totalPage = 1,
    this.offset = 0,
    this.supplierId,
    this.supplierPurchaseList = const [],
  });

  PurchaseWiseSupplierState copyWith({
    bool? loading,
    bool? hasMore,
    int? currentPage,
    int? totalPage,
    int? offset,
    String? supplierId,
    List<SupplierPurchaseItem>? supplierPurchaseList,
  }) {
    return PurchaseWiseSupplierState(
      loading: loading ?? this.loading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      offset: offset ?? this.offset,
      supplierId: supplierId ?? this.supplierId,
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
    fetchSupplierWisePurchases();
    return PurchaseWiseSupplierState();
  }

  Future<void> fetchSupplierWisePurchases({
    bool loadMore = false,
    int? page,
    String? purchaseDate,
  }) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    // final pin = await SharedPreferencesHelper.getString('pin');
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

      state = state.copyWith(
        supplierPurchaseList: newItems,
        offset: newOffset,
        currentPage: newPage,
        hasMore: hasMore,
        totalPage: (totalItem / 10).ceil(),
        // totalPurchase: totalPrice.toString(),
      );
    } catch (e) {
      debugPrint("Error fetching purchases: $e");
    } finally {
      state = state.copyWith(loading: false);
    }
  }
}
