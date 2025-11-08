import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/customer_due/data/repositories/customer_due_repository.dart';
import 'package:pakkahishab/features/supplier_due/data/models/supplier_due_detail_model.dart';
import 'package:pakkahishab/features/supplier_due/data/models/supplier_due_model.dart';
import 'package:pakkahishab/features/supplier_due/data/models/due_supplier_model.dart';

final customerDueViewModelProvider =
    NotifierProvider.autoDispose<CustomerDuesNotifier, CustomerDueState>(
      () => CustomerDuesNotifier(),
    );

final class CustomerDueState {
  final SupplierDueDetailsResponse? supplierDueDetails;
  final DueSupplierResponse? supplier;
  final List<DueSupplier>? filteredSuppliers;
  final bool loading;
  final String totalItem;
  final String totalPrice;
  final bool detailLoading;
  final bool hasMore;
  final int currentPage;
  final int totalPage;
  final String phone;
  final String pin;
  final String offset;
  final List<CustomerDueItem> duesList;
  final String? supplierId;
  final String? paymentMethod;
  // final String purchaseDate;
  // final String supplierId;

  const CustomerDueState({
    this.supplierDueDetails,
    this.supplier,
    this.filteredSuppliers = const [],
    this.loading = false,
    this.totalItem = "0",
    this.totalPrice = "0",
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

  CustomerDueState copyWith({
    SupplierDueDetailsResponse? supplierDueDetails,
    DueSupplierResponse? supplier,
    List<DueSupplier>? filteredSuppliers,
    bool? loading,
    String? totalItem,
    String? totalPrice,
    bool? detailLoading,
    bool? hasMore,
    int? currentPage,
    int? totalPage,
    String? phone,
    String? pin,
    String? offset,
    List<CustomerDueItem>? duesList,
    String? supplierId,
    String? paymentMethod,
  }) {
    return CustomerDueState(
      supplierDueDetails : supplierDueDetails ?? this.supplierDueDetails,
      supplier: supplier ?? this.supplier,
      filteredSuppliers: filteredSuppliers ?? this.filteredSuppliers,
      loading: loading ?? this.loading,
      totalItem: totalItem ?? this.totalItem,
      totalPrice: totalPrice ?? this.totalPrice,
      detailLoading: detailLoading ?? this.detailLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      phone: phone ?? this.phone,
      pin: pin ?? this.pin,
      offset: offset ?? this.offset,
      duesList: duesList ?? this.duesList,
      supplierId: supplierId ?? this.supplierId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}

class CustomerDuesNotifier extends Notifier<CustomerDueState> {
  late final CustomerDueRepository _repo;

  @override
  CustomerDueState build() {
    _repo = ref.read(customerDueRepositoryProvider);
    fetchCustomerDues(); // call async stuff manually
    return const CustomerDueState();
  }

  TextEditingController searchSupplierController = TextEditingController();
  String paymentMethod = "Cash";

  Future<void> fetchCustomerDues({
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

      final result = await _repo.getCustomerDues(
        phone: phone ?? '',
        pin: pin ?? '',
        code: code ?? '',
        offset: newOffset.toString(),
        dueDate: dueDate,
        supplierId: state.supplierId,
      );
      if (kDebugMode) {
        print(result);
      }
      final items = (result['data']['items'] ?? []) as List;
      final hasMore = result['data']['hasMore'] ?? false;
      final totalItem = result['data']['count'] ?? 0;
      print(totalItem);
      state = state.copyWith(totalPage: (totalItem / 10).ceil());
      print(state.totalPage);
      final newItems = items
          .map<CustomerDueItem>((e) => CustomerDueItem.fromJson(e))
          .toList();
      print(newItems.length);
      final allammount = [];
      for (var i in newItems) {
        allammount.add(i.amount);

        print("${i.amount}\n");
      }
      print(allammount);
      final totalPriceSum = allammount.fold<num>(
        0,
        (sum, element) => sum + element,
      );
      print(totalPriceSum);
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
    await fetchCustomerDues();
  }

  void goToPage(int page) {
    fetchCustomerDues(page: page);
  }

  // void refreshPurchases() {
  //   state = const PurchaseState();
  //   fetchPurchases();
  // }

  Future<bool> getSupplierDueDetails({
    bool loadMore = false,
    int? page,
    required String supplierId,
  }) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin') ?? '';
    final code = await SharedPreferencesHelper.getString('code');

    try {
      state = state.copyWith(detailLoading: true);

      final int newPage = page ?? (loadMore ? state.currentPage + 1 : 1);
      final int newOffset = (newPage - 1) * 10;

      final response = await _repo.getSupplierDueDetails(
        phone: phone ?? '',
        pin: pin,
        code: code ?? '',
        offset: newOffset.toString(),
        supplierId: supplierId,
      );

      if (response['statusCode'] == 200) {
        final supplierDueData = SupplierDueDetailsResponse.fromJson(response['data']);
        state = state.copyWith(supplierDueDetails: supplierDueData);
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

  Future<void> getDueSupplier() async {
    state = state.copyWith(detailLoading: true);
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    try {
      final response = await _repo.getDueSupplier(
        phone: phone.toString(),
        pin: pin.toString(),
        code: code.toString(),
      );
      print("supplierDueViewModel");

      print(code.toString());
      if (response['statusCode'] == 200) {
        final responseData = DueSupplierResponse.fromJson(response['data']);
        if (state.filteredSuppliers?.isNotEmpty ?? false) {
          state = state.copyWith(filteredSuppliers: []);
        }
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
            (supplier) => supplier.accountName.toLowerCase().contains(
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
}
