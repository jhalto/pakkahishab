import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/features/sales/data/models/customer_model.dart';
import 'package:pakkahishab/features/sales/data/repositories/sales_repository.dart';
import 'package:riverpod/riverpod.dart';

final saleAddViewModelProvider =
    NotifierProvider.autoDispose<SalesAddNotifier, SalesAddState>(
      () => SalesAddNotifier(),
    );

final class SalesAddState {
  final bool isLoading;
  final String? errorMessage;
  final CustomerResponse? customer;
  final List<Customer>? filteredCustomer;
  final Map<String, dynamic>? response;

  SalesAddState({
    this.isLoading = false,
    this.customer,
    this.filteredCustomer,
    this.errorMessage,
    this.response,
  });

  SalesAddState copyWith({
    bool? isLoading,
    final CustomerResponse? customer,
    final List<Customer>? filteredCustomer,
    String? errorMessage,
    Map<String, dynamic>? response,
  }) {
    return SalesAddState(
      isLoading: isLoading ?? this.isLoading,
      customer: customer ?? this.customer,
      filteredCustomer: filteredCustomer ?? this.filteredCustomer,
      errorMessage: errorMessage,
      response: response ?? this.response,
    );
  }
}

class SalesAddNotifier extends Notifier<SalesAddState> {
  late final SalesRepository _repo;

  @override
  SalesAddState build() {
    _repo = ref.read(salesRepositoryProvider);
    Future.microtask(() => getSaleCustomer());
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

      state = state.copyWith(isLoading: false, response: response);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Failed to add sale: $e",
      );
    }
  }

 Future<void> getSaleCustomer() async {
  state = state.copyWith(isLoading: true);
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
      print(response['data']);
      final responseData = CustomerResponse.fromJson(response['data']);
      state = state.copyWith(
        isLoading: false,  // ✅ Set loading false here
        customer: responseData,
        filteredCustomer: responseData.items,
      );
      print(state.filteredCustomer);
      print("done");
    } else {
      print("error $response");
      state = state.copyWith(isLoading: false);  // ✅ Also set here
    }
  } catch (e) {
    print(e);
    state = state.copyWith(isLoading: false);  // ✅ And here
  }
  // Remove the finally block entirely
}

    void searchCustomer(String query) {
    final allCustomers = state.customer?.items ?? [];

    if (query.isEmpty) {
      // if query is empty, show all suppliers
      state = state.copyWith(filteredCustomer: allCustomers);
    } else {
      final filtered = allCustomers
          .where(
            (supplier) => supplier.customerName.toLowerCase().contains(
              query.toLowerCase(),
            ),
          )
          .toList();
      state = state.copyWith(filteredCustomer: filtered);
    }
  }
}
