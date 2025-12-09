import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/sales/data/models/all_customer_model.dart';
import 'package:pakkahishab/features/sales/data/repositories/sales_repository.dart';
import 'package:riverpod/riverpod.dart';

final saleAddViewModelProvider =
    NotifierProvider.autoDispose<SalesAddNotifier, SalesAddState>(
      () => SalesAddNotifier(),
    );

final class SalesAddState {
  final bool isLoading;
  final String? errorMessage;
  final AllCustomerModel? customer;
  final List<AllCustomer>? filteredCustomer;
  final String? customerId;

  SalesAddState({
    this.isLoading = false,
    this.customer,
    this.filteredCustomer,
    this.errorMessage,
    this.customerId,
  });

  SalesAddState copyWith({
    bool? isLoading,
    final AllCustomerModel? customer,
    final List<AllCustomer>? filteredCustomer,
    String? errorMessage,
    String? customerId,
  }) {
    return SalesAddState(
      isLoading: isLoading ?? this.isLoading,
      customer: customer ?? this.customer,
      filteredCustomer: filteredCustomer ?? this.filteredCustomer,
      errorMessage: errorMessage ?? errorMessage,
      customerId: customerId ?? customerId,
    );
  }
}

class SalesAddNotifier extends Notifier<SalesAddState> {
  late final SalesRepository _repo;

  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerPhoneController = TextEditingController();
  TextEditingController customerEmailController = TextEditingController();
  TextEditingController customerAddressController = TextEditingController();
  TextEditingController customerOpeningBalanceController =
      TextEditingController();

  final customerAddFormKey = GlobalKey<FormState>();

  @override
  SalesAddState build() {
    _repo = ref.read(salesRepositoryProvider);
    Future.microtask(() => getAllCustomer());
    return SalesAddState();
  }

  Future<void> addSale({
    required String phone,
    required String pin,
    required String schoolCode,
    required String customerId,
    required int salesType,
    required double netAmount,
    required double due,
    required double paidPrice,
    required List<Map<String, dynamic>> salesDetails,
    DateTime? date,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await _repo.addSales(
        phone: phone,
        pin: pin,
        schoolCode: schoolCode,
        customerId: customerId,
        salesType: salesType,
        netAmount: netAmount,
        due: due,
        paidPrice: paidPrice,
        date: date,
      );

      // If the API expects sales_details as part of body
      // you may need to send salesDetails inside addSales method in repository
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Failed to add sale: $e",
      );
    }
  }

  Future<void> getAllCustomer() async {
    state = state.copyWith(isLoading: true);
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    try {
      final response = await _repo.getAllCustomer(
        phone: phone.toString(),
        pin: pin.toString(),
        code: code.toString(),
      );
      print(response);
      if (response['statusCode'] == 200) {
        print(response['data']);
        final responseData = AllCustomerModel.fromJson(response['data']);
        state = state.copyWith(
          isLoading: false, // ✅ Set loading false here
          customer: responseData,
          filteredCustomer: responseData.items,
        );
        print(state.filteredCustomer);
        print("done");
      } else {
        print("error $response");
        state = state.copyWith(isLoading: false); // ✅ Also set here
      }
    } catch (e) {
      print(e);
      state = state.copyWith(isLoading: false); // ✅ And here
    }
    // Remove the finally block entirely
  }
  
  void updateCustomerId(String customerId){
    state = state.copyWith(customerId: customerId);
  }

  void searchCustomer(String query) {
    final allCustomers = state.customer?.items ?? [];

    if (query.isEmpty) {
      // if query is empty, show all suppliers
      state = state.copyWith(filteredCustomer: allCustomers);
    } else {
      final filtered = allCustomers
          .where(
            (supplier) => supplier.supplierName.toLowerCase().contains(
              query.toLowerCase(),
            ),
          )
          .toList();
      state = state.copyWith(filteredCustomer: filtered);
    }
  }

  Future<void> addCustomer() async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    final response = await _repo.addCustomer(
      code: code.toString(),
      mobile: phone.toString(),
      pin: pin.toString(),
      customerName: customerNameController.text.trim(),
      customerEmail: customerEmailController.text.trim(),
      customerPhone: customerPhoneController.text.trim(),
      customerAddress: customerAddressController.text.trim(),
      openingBalance: int.tryParse(customerOpeningBalanceController.text.trim())?? 0,
    );

    print(response);
  }
}
