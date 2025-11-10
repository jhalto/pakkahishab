import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/customer_due/data/models/customer_due_detail_model.dart';
import 'package:pakkahishab/features/customer_due/data/models/customer_due_model.dart';
import 'package:pakkahishab/features/customer_due/data/models/due_customer_model.dart';
import 'package:pakkahishab/features/customer_due/data/repositories/customer_due_repository.dart';
import 'package:pakkahishab/features/sales/data/models/sale_details_model.dart';
import 'package:pakkahishab/features/sales/data/models/sales_model.dart';

final customerDueViewModelProvider =
    NotifierProvider.autoDispose<CustomerDuesNotifier, CustomerDueState>(
      () => CustomerDuesNotifier(),
    );

final class CustomerDueState {
  final CustomerDueDetailsResponse? customerDueDetails;
  final List<SalesItem> salesList;
  final SalesDetailsResponse? salesDetails;
  final DueCustomerResponse? customer;
  final List<DueCustomer>? filteredCustomers;
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
  final String? customerId;
  final String? paymentMethod;
  final String? customerTotalDues;
  final String? customerTotalDuesCount;
  // final String purchaseDate;
  // final String supplierId;

  const CustomerDueState({
    this.customerDueDetails,
    this.salesList = const [],
    this.salesDetails,
    this.customer,
    this.filteredCustomers = const [],
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
    this.customerId,
    this.paymentMethod,
    this.customerTotalDues,
    this.customerTotalDuesCount
  });

  CustomerDueState copyWith({
    CustomerDueDetailsResponse? customerDueDetails,
    SalesDetailsResponse? salesDetails,
    List<SalesItem>? salesList,
    DueCustomerResponse? customer,
    List<DueCustomer>? filteredCustomers,
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
    String? customerId,
    String? paymentMethod,
    String? customerTotalDues,
    String? customerTotalDuesCount,
  }) {
    return CustomerDueState(
      customerDueDetails : customerDueDetails ?? this.customerDueDetails,
      salesDetails: salesDetails ?? this.salesDetails,
      salesList: salesList ?? this.salesList,
      customer: customer ?? this.customer,
      filteredCustomers: filteredCustomers ?? this.filteredCustomers,
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
      customerId: customerId ?? this.customerId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      customerTotalDues: customerTotalDues ?? this.customerTotalDues,
      customerTotalDuesCount: customerTotalDuesCount ?? this.customerTotalDuesCount,
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

  TextEditingController searchCustomerController = TextEditingController();
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
        dueDate: dueDate ?? '',
        customerId: state.customerId ?? '',
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

  void updateCustomerId(String customerId) {
    state = state.copyWith(customerId: customerId);
  }

  Future<void> refreshPurchases() async {
    state = state.copyWith(customerId: "");
    await fetchCustomerDues();
  }

  void goToPage(int page) {
    fetchCustomerDues(page: page);
  }

  // void refreshPurchases() {
  //   state = const PurchaseState();
  //   fetchPurchases();
  // }

  Future<bool> getCustomerDueDetails({
    bool loadMore = false,
    int? page,
    required String customerId,
  }) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin') ?? '';
    final code = await SharedPreferencesHelper.getString('code');

    try {
      state = state.copyWith(loading: true);

      final int newPage = page ?? (loadMore ? state.currentPage + 1 : 1);
      final int newOffset = (newPage - 1) * 10;

      final response = await _repo.getCustomerDueDetails(
        phone: phone ?? '',
        pin: pin,
        code: code ?? '',
        offset: newOffset.toString(),
        customerId: customerId,
      );

      if (response['statusCode'] == 200) {
        final customerDueData = CustomerDueDetailsResponse.fromJson(response['data']);
        state = state.copyWith(customerDueDetails: customerDueData);
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

  Future<void> getDueCustomer() async {
    state = state.copyWith(detailLoading: true);
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    try {
      final response = await _repo.getDueCustomer(
        phone: phone.toString(),
        pin: pin.toString(),
        code: code.toString(),
      );
      print("customer");

      print(code.toString());
      if (response['statusCode'] == 200) {
        final responseData = DueCustomerResponse.fromJson(response['data']);
        if (state.filteredCustomers?.isNotEmpty ?? false) {
          state = state.copyWith(filteredCustomers: []);
        }
        state = state.copyWith(
          customer: responseData,
          filteredCustomers: responseData.items,
        );

        print(state.filteredCustomers);
      } else {
        print("error $response");
      }
    } catch (e) {
      print(e);
    } finally {
      state = state.copyWith(detailLoading: false);
    }
  }

  void searchCustomer(String query) {
    final allCustomers = state.customer?.items ?? [];

    if (query.isEmpty) {
      // if query is empty, show all suppliers
      state = state.copyWith(filteredCustomers: allCustomers);
    } else {
      final filtered = allCustomers
          .where(
            (customer) => customer.accountName.toLowerCase().contains(
              query.toLowerCase(),
            ),
          )
          .toList();
      state = state.copyWith(filteredCustomers: filtered);
    }
  }

  void updatePaymentMethod(String value) {
    state = state.copyWith(paymentMethod: value);
  }
  Future<void> fetchCustomerDueSales({
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

      final result = await _repo.getCustomerSales(
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
   Future<bool> fetchCustomerSalesDetails({
    bool loadMore = false,
    int? page,
    required String saleNo,
  }) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    try {
      state = state.copyWith(detailLoading: true);

      final int newPage = page ?? (loadMore ? state.currentPage + 1 : 1);
      final int newOffset = (newPage - 1) * 10;

      final response = await _repo.getCustomerSaleDetails(
        phone: phone ?? '',
        pin: pin ??"",
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
}
