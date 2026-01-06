import 'package:flutter/material.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/core/utils/show_snackbar.dart';

import 'package:pakkahishab/features/sales/data/models/all_customer_model.dart';
import 'package:pakkahishab/features/sales/data/models/sales_product_model.dart';
import 'package:pakkahishab/features/sales/data/repositories/sales_repository.dart';
import 'package:riverpod/riverpod.dart';

final saleAddViewModelProvider =
    NotifierProvider.autoDispose<SalesAddNotifier, SalesAddState>(
      () => SalesAddNotifier(),
    );
final productListProviderSales = FutureProvider<List<AllProduct>>((ref) async {
  try {
    final _repo = ref.watch(salesRepositoryProvider);

    final phone = await SharedPreferencesHelper.getString('phone') ?? '';
    final pin = await SharedPreferencesHelper.getString('pin') ?? '';
    final code = await SharedPreferencesHelper.getString('code') ?? '';

    final response = await _repo.getAllProduct(
      mobile: phone,
      pin: pin,
      code: code,
    );

    print("API Response: $response");

    if (response['success'] == true) {
      final model = AllProductResponse.fromJson(response['data']);
      print("Parsed items: ${model.items.length}");
      return model.items;
    } else {
      final message = response['message'] ?? "Failed to load Product";
      throw Exception(message);
    }
  } catch (e) {
    print("Error: $e");
    throw Exception("Something went wrong: $e");
  }
});

final class SalesAddState {
  final bool isLoading;
  final String? errorMessage;
  final AllCustomerModel? customer;
  final List<AllCustomer>? filteredCustomer;
  final String? customerId;
  final List<SaleDetailsProduct>? selectedSaleProducts;

  SalesAddState({
    this.isLoading = false,
    this.customer,
    this.filteredCustomer,
    this.errorMessage,
    this.customerId,
    this.selectedSaleProducts,
  });

  SalesAddState copyWith({
    bool? isLoading,
    final AllCustomerModel? customer,
    final List<AllCustomer>? filteredCustomer,
    String? errorMessage,
    String? customerId,
    List<SaleDetailsProduct>? selectedSaleProducts,
  }) {
    return SalesAddState(
      isLoading: isLoading ?? this.isLoading,
      customer: customer ?? this.customer,
      filteredCustomer: filteredCustomer ?? this.filteredCustomer,
      errorMessage: errorMessage ?? errorMessage,
      customerId: customerId ?? customerId,
      selectedSaleProducts: selectedSaleProducts ?? selectedSaleProducts,
    );
  }
}

class SalesAddNotifier extends Notifier<SalesAddState> {
  late final SalesRepository _repo;
  // Customer add controller and variable
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerPhoneController = TextEditingController();
  TextEditingController customerEmailController = TextEditingController();
  TextEditingController customerAddressController = TextEditingController();
  TextEditingController customerOpeningBalanceController =
      TextEditingController();

  final customerAddFormKey = GlobalKey<FormState>();

  // Product item controller and variable

  TextEditingController saleProductQuantity = TextEditingController(
    text: 1.toString(),
  );
  String selectedSaleProductName = '';
  String selectedSaleProductPrice = '';
  String selectedSaleProductId = '';

  // purchase controller and variable

  TextEditingController saleNetAmountController = TextEditingController();

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

  void updateCustomerId(String customerId) {
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

  Future<void> addCustomer(BuildContext context) async {
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
      openingBalance:
          int.tryParse(customerOpeningBalanceController.text.trim()) ?? 0,
    );

    if (response['data']['status'] == 'success') {
      if (!context.mounted) return;
      showCustomSnackBar(context, "Customer inserted successfully", type: SnackBarType.success);
      Navigator.pop(context);
      getAllCustomer();
    } else {
      if (!context.mounted) return;

      showCustomSnackBar(context, response['data']['message']);
    }
  }

  // Future<void> showProductAddBottomSheet(BuildContext context) async {
  //   showModalBottomSheet(
  //     backgroundColor: Colors.white,
  //     context: context,
  //     builder: (context) {
  //       return Consumer(
  //         builder: (context, ref, _) {
  //           final _vm = ref.watch(
  //             purchaseAddViewModelProvider,
  //           ); // <- watch here
  //           final _vmn = ref.watch(purchaseAddViewModelProvider.notifier);
  //           return Stack(
  //             children: [
  //               Padding(
  //                 padding: EdgeInsets.only(
  //                   bottom: MediaQuery.of(context).viewInsets.bottom,
  //                   left: 18,
  //                   right: 18,
  //                   top: 20,
  //                 ),
  //                 child: SingleChildScrollView(
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Container(
  //                         height: 5,
  //                         width: 40,
  //                         decoration: BoxDecoration(
  //                           color: Colors.grey.shade400,
  //                           borderRadius: BorderRadius.circular(20),
  //                         ),
  //                       ),
  //                       SizedBox(height: 20),

  //                       Text(
  //                         "Add New Product",
  //                         style: TextStyle(
  //                           fontSize: 20,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),

  //                       SizedBox(height: 20),

  //                       Form(
  //                         key: _vmn.customerAddFormKey,
  //                         child: Column(
  //                           children: [
  //                             CustomPakkaFormField(
  //                               controller: _vmn.productNameController,
  //                               label: "Product Name *",
  //                               validator: (value) =>
  //                                   Validation.validateName(value, context),
  //                               textInputAction: TextInputAction.next,
  //                             ),

  //                             SizedBox(height: 12),

  //                             CustomPakkaFormField(
  //                               controller: _vmn.productPriceController,
  //                               label: "Product Purchase Price",
  //                               textInputAction: TextInputAction.next,
  //                             ),
  //                             SizedBox(height: 12),

  //                             CustomPakkaFormField(
  //                               controller: _vmn.productSellPriceController,
  //                               label: "Product Sell Price",
  //                               textInputAction: TextInputAction.next,
  //                             ),
  //                             SizedBox(height: 12),
  //                             InkWell(
  //                               borderRadius: BorderRadius.all(
  //                                 Radius.circular(8),
  //                               ),
  //                               onTap: () async {
  //                                 final date = await pickDate(context: context);
  //                                 if (date != null) {
  //                                   updateManufacturingDate(date: date);
  //                                 }
  //                               },
  //                               child: Ink(
  //                                 width: double.infinity,
  //                                 padding: EdgeInsets.symmetric(
  //                                   vertical: 14,
  //                                   horizontal: 19,
  //                                 ),
  //                                 decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.all(
  //                                     Radius.circular(8),
  //                                   ),
  //                                   color: AppColors.fillColor,
  //                                   border: Border.all(color: Colors.grey),
  //                                 ),
  //                                 child: Row(
  //                                   mainAxisAlignment: .spaceBetween,
  //                                   children: [
  //                                     Text(
  //                                       "Product Stock-In : ${_vm.selectedManufacturingDate}",
  //                                       style: AppTextStyle.bodyMediumSecondary,
  //                                     ),
  //                                     Icon(Icons.calendar_today_outlined),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                             SizedBox(height: 12),
  //                             InkWell(
  //                               borderRadius: BorderRadius.all(
  //                                 Radius.circular(8),
  //                               ),
  //                               onTap: () async {
  //                                 final date = await pickDate(context: context);
  //                                 if (date != null) {
  //                                   updateExpireDate(expireDate: date);
  //                                 }
  //                               },
  //                               child: Ink(
  //                                 width: double.infinity,
  //                                 padding: EdgeInsets.symmetric(
  //                                   vertical: 14,
  //                                   horizontal: 19,
  //                                 ),
  //                                 decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.all(
  //                                     Radius.circular(8),
  //                                   ),
  //                                   color: AppColors.fillColor,
  //                                   border: Border.all(color: Colors.grey),
  //                                 ),
  //                                 child: Row(
  //                                   mainAxisAlignment: .spaceBetween,
  //                                   children: [
  //                                     Text(
  //                                       "Product Expire-In : ${_vm.selectedExpiredDate}",
  //                                       style: AppTextStyle.bodyMediumSecondary,
  //                                     ),
  //                                     Icon(Icons.calendar_today_outlined),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),

  //                             SizedBox(height: 12),

  //                             CustomPakkaFormField(
  //                               controller: _vmn.productStockController,
  //                               label: "Product Stock",
  //                               textInputAction: TextInputAction.done,
  //                               onComplete: () async {
  //                                 if (_vmn.customerAddFormKey.currentState!
  //                                     .validate()) {
  //                                   await _vmn.addProduct(context);

  //                                   /// reload supplier list
  //                                 }
  //                               },
  //                             ),
  //                             SizedBox(height: 12),
  //                           ],
  //                         ),
  //                       ),

  //                       SizedBox(height: 20),

  //                       SizedBox(
  //                         width: double.infinity,
  //                         child: ElevatedButton(
  //                           style: ElevatedButton.styleFrom(
  //                             backgroundColor: AppColors.primaryColor,
  //                             padding: EdgeInsets.symmetric(vertical: 14),
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                           ),
  //                           onPressed: () async {
  //                             if (_vmn.customerAddFormKey.currentState!
  //                                 .validate()) {
  //                               await _vmn.addProduct(context);

  //                               /// reload supplier list
  //                             }
  //                           },
  //                           child: Text(
  //                             "Save Product",
  //                             style: TextStyle(
  //                               color: Colors.white,
  //                               fontSize: 16,
  //                             ),
  //                           ),
  //                         ),
  //                       ),

  //                       SizedBox(height: 16),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               if (_vm.isLoading)
  //                 Positioned.fill(
  //                   child: Container(
  //                     color: Colors.black.withAlpha(25),
  //                     child: Center(
  //                       child: loader, // your custom loader
  //                     ),
  //                   ),
  //                 ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  void calculatePurchaseAmounts() {
    final products = state.selectedSaleProducts ?? [];

    final calculatedNetAmount = products.fold<double>(
      0.0,
      (sum, item) => sum + (item.unitPrice * item.quantity),
    );

    // ✅ ALWAYS update net amount
    saleNetAmountController.text = calculatedNetAmount.toStringAsFixed(0);
  }

  Future<void> addProductInSaleList(BuildContext context) async {
    final existingProducts = state.selectedSaleProducts ?? [];

    final newProduct = SaleDetailsProduct(
      productName: selectedSaleProductName,
      productId: selectedSaleProductId,
      unitPrice: double.tryParse(selectedSaleProductPrice) ?? 0.0,
      quantity: int.tryParse(saleProductQuantity.text) ?? 0,
    );

    final index = existingProducts.indexWhere(
      (item) => item.productId == newProduct.productId,
    );

    List<SaleDetailsProduct> updatedProducts = [];

    if (index != -1) {
      final existing = existingProducts[index];

      final updatedItem = SaleDetailsProduct(
        productName: existing.productName,
        productId: existing.productId,
        unitPrice: existing.unitPrice,
        quantity: newProduct.quantity,
      );

      updatedProducts = [...existingProducts];
      updatedProducts[index] = updatedItem;
    } else {
      updatedProducts = [...existingProducts, newProduct];
    }

    // Update state
    state = state.copyWith(selectedSaleProducts: updatedProducts);

    // 🔥 Update amounts
    calculatePurchaseAmounts();

    Navigator.pop(context);
  }



  Future<void> addSales()async{
    state = state.copyWith(isLoading: true);
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    // final response = await _repo.addSales(phone: phone.toString(), pin: pin.toString(), schoolCode: code.toString(), customerId: state.customerId.toString(), salesType: salesType, netAmount: netAmount, due: due, paidPrice: paidPrice)

    


  }
}
