import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/global_widgets/custom_pakka_form_field.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/core/helper/validation_helper.dart';
import 'package:pakkahishab/core/utils/loader.dart';
import 'package:pakkahishab/core/utils/show_snackbar.dart';
import 'package:pakkahishab/features/purchase/data/models/all_product_model.dart';
import 'package:pakkahishab/features/purchase/data/models/all_supplier_model.dart';
import 'package:pakkahishab/features/purchase/data/repositories/purchase_repository.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_product_details_add_widget.dart';
import 'package:riverpod/riverpod.dart';

final purchaseAddViewModelProvider =
    NotifierProvider.autoDispose<PurchaseAddNotifier, PurchaseAddState>(
      () => PurchaseAddNotifier(),
    );

final supplierListProvider = FutureProvider<List<AllSupplier>>((ref) async {
  final repo = ref.watch(purchaseRepositoryProvider);

  final phone = await SharedPreferencesHelper.getString('phone');
  final pin = await SharedPreferencesHelper.getString('pin');
  final code = await SharedPreferencesHelper.getString('code');

  final response = await repo.getAllSupplier(
    phone: phone.toString(),
    pin: pin.toString(),
    code: code.toString(),
  );

  if (response['statusCode'] == 200) {
    final model = AllSupplierModel.fromJson(response['data']);
    return model.items;
  } else {
    throw Exception("Failed to load suppliers");
  }
});

final productListProvider = FutureProvider<List<AllProduct>>((ref) async {
  try {
    final _repo = ref.watch(purchaseRepositoryProvider);

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

final class PurchaseAddState {
  final bool isLoading;
  final String? errorMessage;

  final String? selectedManufacturingDate;
  final String? purchaseDate;
  final String? selectedExpiredDate;
  final String? supplierId;
  final String? paymentMethod;
  final String? purchaseType;

  final List<PurchaseDetailsProduct>? selectedPurchaseProducts;

  PurchaseAddState({
    this.isLoading = false,

    String? selectedManufacturingDate,
    String? purchaseDate,
    this.selectedExpiredDate,
    this.errorMessage,
    this.supplierId,
    this.paymentMethod,
    this.purchaseType = "Credit",
    this.selectedPurchaseProducts,
  }) : selectedManufacturingDate =
           selectedManufacturingDate ??
           DateFormat('yyyy-MM-dd').format(DateTime.now()),
       purchaseDate =
           purchaseDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now());

  PurchaseAddState copyWith({
    bool? isLoading,
    String? selectedManufacturingDate,
    String? selectedExpiredDate,
    String? purchaseDate,
    String? errorMessage,
    String? supplierId,
    String? paymentMethod,
    String? purchaseType,

    List<PurchaseDetailsProduct>? selectedPurchaseProducts,
  }) {
    return PurchaseAddState(
      isLoading: isLoading ?? this.isLoading,
      selectedManufacturingDate:
          selectedManufacturingDate ?? this.selectedManufacturingDate,
      selectedExpiredDate: selectedExpiredDate ?? this.selectedExpiredDate,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      errorMessage: errorMessage ?? this.errorMessage,
      supplierId: supplierId ?? this.supplierId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      purchaseType: purchaseType ?? this.purchaseType,
      selectedPurchaseProducts:
          selectedPurchaseProducts ?? this.selectedPurchaseProducts,
    );
  }
}

class PurchaseAddNotifier extends Notifier<PurchaseAddState> {
  late final PurchaseRepository _repo;
  // supplier add controllers
  TextEditingController supplierNameController = TextEditingController();
  TextEditingController supplierPhoneController = TextEditingController();
  TextEditingController supplierEmailController = TextEditingController();
  TextEditingController supplierAddressController = TextEditingController();
  TextEditingController supplierOpeningBalanceController =
      TextEditingController();
  // product add controllers
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productSellPriceController = TextEditingController();
  TextEditingController productCodeController = TextEditingController();
  TextEditingController productStockController = TextEditingController();

  void clearProductAddController() {
    productCodeController.clear();
    productNameController.clear();
    productSellPriceController.clear();
    productStockController.clear();
    productPriceController.clear();
  }
  // purchase product add controllers and variable

  TextEditingController purchaseProductQuantity = TextEditingController(
    text: 1.toString(),
  );
  String selectedPurchaseProductName = '';
  String selectedPurchaseProductPrice = '';
  String selectedPurchaseProductId = '';

  // purchase purchase add controllers and variable

  TextEditingController purchaseNetAmmountController = TextEditingController();
  TextEditingController purchasetotalAmountController = TextEditingController();
  TextEditingController purchasePaidPriceController = TextEditingController();
  TextEditingController purchaseDuePriceController = TextEditingController();

  // payment method
  int purchaseType = 0;
  String paymentMethod = '';

  void _updateDueAmount() {
    double totalAmount =
        double.tryParse(purchasetotalAmountController.text) ?? 0.0;
    double paidAmount =
        double.tryParse(purchasePaidPriceController.text) ?? 0.0;
    double dueAmount = totalAmount - paidAmount;

    purchaseDuePriceController.text = dueAmount.toStringAsFixed(2);
  }

  void calculatePurchaseAmounts() {
    final products = state.selectedPurchaseProducts ?? [];

    double netAmount = products.fold(
      0.0,
      (sum, item) => sum + (item.unitPrice * item.quantity),
    );

    double totalAmount =
        netAmount; // If you add VAT or discount later, update here

    double paidPrice = double.tryParse(purchasePaidPriceController.text) ?? 0.0;

    double duePrice = totalAmount - paidPrice;

    // Update controllers
    purchaseNetAmmountController.text = netAmount.toStringAsFixed(2);
    purchasetotalAmountController.text = totalAmount.toStringAsFixed(2);
    purchaseDuePriceController.text = duePrice.toStringAsFixed(2);
    _updateDueAmount();
  }

  void updatePurchaseType(String value) {
    state = state.copyWith(purchaseType: value);
  }

  Future<void> addProductInPurchaseList(BuildContext context) async {
    final existingProducts = state.selectedPurchaseProducts ?? [];

    final newProduct = PurchaseDetailsProduct(
      productName: selectedPurchaseProductName,
      productId: selectedPurchaseProductId,
      unitPrice: double.tryParse(selectedPurchaseProductPrice) ?? 0.0,
      quantity: int.tryParse(purchaseProductQuantity.text) ?? 0,
    );

    final index = existingProducts.indexWhere(
      (item) => item.productId == newProduct.productId,
    );

    List<PurchaseDetailsProduct> updatedProducts = [];

    if (index != -1) {
      final existing = existingProducts[index];

      final updatedItem = PurchaseDetailsProduct(
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
    state = state.copyWith(selectedPurchaseProducts: updatedProducts);

    // 🔥 Update amounts
    calculatePurchaseAmounts();

    Navigator.pop(context);
  }

  void updatePaymentMethod(String value) {
    state = state.copyWith(paymentMethod: value);
  }

  final customerAddFormKey = GlobalKey<FormState>();

  @override
  PurchaseAddState build() {
    _repo = ref.read(purchaseRepositoryProvider);
    purchasePaidPriceController.addListener(_updateDueAmount);

    return PurchaseAddState();
  }

  // Future<void> addSale({
  //   required String phone,
  //   required String pin,
  //   required String schoolCode,
  //   required String customerId,
  //   required int salesType,
  //   required double netAmount,
  //   required double due,
  //   required double paidPrice,
  //   required List<Map<String, dynamic>> salesDetails,
  //   DateTime? date,
  // }) async {
  //   state = state.copyWith(isLoading: true, errorMessage: null);

  //   try {
  //     final response = await _repo.addSales(
  //       phone: phone,
  //       pin: pin,
  //       schoolCode: schoolCode,
  //       customerId: customerId,
  //       salesType: salesType,
  //       netAmount: netAmount,
  //       due: due,
  //       paidPrice: paidPrice,
  //       date: date,
  //     );

  //     // If the API expects sales_details as part of body
  //     // you may need to send salesDetails inside addSales method in repository
  //   } catch (e) {
  //     state = state.copyWith(
  //       isLoading: false,
  //       errorMessage: "Failed to add sale: $e",
  //     );
  //   }
  // }

  // Future<void> getAllSupplier() async {
  //   state = state.copyWith(isLoading: true);
  //   final phone = await SharedPreferencesHelper.getString('phone');
  //   final pin = await SharedPreferencesHelper.getString('pin');
  //   final code = await SharedPreferencesHelper.getString('code');

  //   try {
  //     final response = await _repo.getAllSupplier(
  //       phone: phone.toString(),
  //       pin: pin.toString(),
  //       code: code.toString(),
  //     );
  //     print(response);
  //     if (response['statusCode'] == 200) {
  //       print(response['data']);
  //       final responseData = AllSupplierModel.fromJson(response['data']);
  //       state = state.copyWith(
  //         isLoading: false, // ✅ Set loading false here
  //         supplier: responseData,
  //         filteredSupplier: responseData.items,
  //       );
  //       print("done");
  //     } else {
  //       print("error $response");
  //       state = state.copyWith(isLoading: false); // ✅ Also set here
  //     }
  //   } catch (e) {
  //     print(e);
  //     state = state.copyWith(isLoading: false); // ✅ And here
  //   }
  //   // Remove the finally block entirely
  // }

  void updateSupplierId(String supplierId) {
    state = state.copyWith(supplierId: supplierId);

    print(state.supplierId);
  }

  // void searchCustomer(String query) {
  //   final allCustomers = state.customer?.items ?? [];

  //   if (query.isEmpty) {
  //     // if query is empty, show all suppliers
  //     state = state.copyWith(filteredCustomer: allCustomers);
  //   } else {
  //     final filtered = allCustomers
  //         .where(
  //           (supplier) => supplier.supplierName.toLowerCase().contains(
  //             query.toLowerCase(),
  //           ),
  //         )
  //         .toList();
  //     state = state.copyWith(filteredCustomer: filtered);
  //   }
  // }

  Future<void> addSupplier(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');
    await Future.delayed(Duration(seconds: 2));
    final response = await _repo.addSupplier(
      code: code.toString(),
      mobile: phone.toString(),
      pin: pin.toString(),
      customerName: supplierNameController.text.trim(),
      customerEmail: supplierEmailController.text.trim(),
      customerPhone: supplierPhoneController.text.trim(),
      customerAddress: supplierAddressController.text.trim(),
      openingBalance:
          int.tryParse(supplierOpeningBalanceController.text.trim()) ?? 0,
    );

    if (response['statusCode'] == 200 &&
        response['data']['status'] == 'success') {
      state = state.copyWith(isLoading: false);
      if (!context.mounted) return;
      Navigator.pop(context);
      showCustomSnackBar(
        context,
        "Suppliers inserted successfully",
        type: SnackBarType.success,
      );
      // getAllSupplier();
      supplierNameController.clear();
      supplierPhoneController.clear();
      supplierEmailController.clear();
      supplierAddressController.clear();
      supplierOpeningBalanceController.clear();
    } else if (response['statusCode'] == 200 &&
        response['data']['message'] ==
            'ORA-00001: unique constraint (DEV.CONS_SUPMOBILE) violated') {
      state = state.copyWith(isLoading: false);

      if (!context.mounted) return;

      showCustomSnackBar(context, "The Phone number is Already taken");
    }
  }

  Future<void> addProduct(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    print(phone);
    print(pin);
    print(code);

    final List<AddProductItem> productList = [
      AddProductItem(
        name: productNameController.text.trim(),
        purchasePrice: double.tryParse(productPriceController.text.trim()),
        sellPrice: double.tryParse(productSellPriceController.text.trim()),
        manufacturingDate: state.selectedManufacturingDate.toString(),
        productStock: productStockController.text.trim(),
        productCode: productCodeController.text.trim(),
      ),
    ];
    print(productList.first.name);
    print(productList.first.purchasePrice);
    print(productList.first.sellPrice);
    print(productList.first.manufacturingDate);
    print(productList.first.productStock);
    print(productList.first.productCode);
    try {
      final response = await _repo.addProduct(
        code: code.toString(),
        mobile: phone.toString(),
        pin: pin.toString(),
        product: productList,
      );
      print(response);

      if (response['statusCode'] == 200 &&
          response['data']['status'] == 'success') {
        state = state.copyWith(isLoading: false);

        if (!context.mounted) return;
        FocusScope.of(context).unfocus();
        Navigator.pop(context);

        showCustomSnackBar(
          context,
          "Products inserted successfully",
          type: SnackBarType.success,
        );
        // selectedPurchaseProductId = response['data']['inserted_products'][0]['product_id'];
        // selectedPurchaseProductName = productList.first.name;
        // selectedPurchaseProductPrice = productList.first.purchasePrice.toString();
        // purchaseProductQuantity.text = "1";

        // selectedPurchaseProductId = productList.first.;

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PurchaseProductDetailsAddWidget(
        //       selectedProductAdd: productList.first,
        //     ),
        //   ),
        // );
        ref.invalidate(productListProvider);
        clearProductAddController();
      } else if (response['data']['status'] == 'error') {
        state = state.copyWith(isLoading: false);
        if (!context.mounted) return;
        showCustomSnackBar(context, response['data']['message']);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print(e);
    }
  }

  String generateInvoiceNumber() {
    final random = Random();
    String numbers = '';

    for (int i = 0; i < 8; i++) {
      numbers += random.nextInt(10).toString(); // generates a digit 0-9
    }

    return 'PM$numbers';
  }

  List<Map<String, dynamic>> getPurchaseDetailsApiFormat(
    List<PurchaseDetailsProduct> products,
  ) {
    return products
        .map(
          (p) => {
            "product_id": int.tryParse(p.productId) ?? 0,
            "quantity": p.quantity,
            "unit_price": p.unitPrice,
          },
        )
        .toList();
  }

  void updatePurchaseDate({required String date}) {
    state = state.copyWith(purchaseDate: date);
  }

  Future<void> addPurchase(BuildContext context) async {
    state = state.copyWith(isLoading: true);

    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    final purchaseTypeValue = state.purchaseType == 'Credit' ? "0" : "1";

    // Safe product list (empty allowed)
    final productList = (state.selectedPurchaseProducts ?? [])
        .map(
          (p) => {
            "product_id": int.tryParse(p.productId) ?? 0,
            "quantity": p.quantity,
            "unit_price": p.unitPrice,
          },
        )
        .toList();

    // 🔥 IMPORTANT: await
    final response = await _repo.addPurchase(
      purchaseDate: state.purchaseDate.toString(),
      supplierId: state.supplierId.toString(),
      purchaseType: purchaseTypeValue,
      netAmount: purchaseNetAmmountController.text.trim(),
      due: purchaseDuePriceController.text.trim(),
      paidPrice: purchasePaidPriceController.text.trim(),
      mobile: phone ?? "",
      password: pin ?? "",
      schoolCode: code ?? "",
      productList: productList, // works even when empty
    );

    print(response);

    if (response['data']['status'] == 'success') {
      if (!context.mounted) return;
      showCustomSnackBar(context, "Purchase Add Successfully");
    } else if (response['data']['status'] == 'error') {}

    state = state.copyWith(isLoading: false);
  }

  Future<void> showProductAddBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      // isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            final _vm = ref.watch(
              purchaseAddViewModelProvider,
            ); // <- watch here
            final _vmn = ref.watch(purchaseAddViewModelProvider.notifier);
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 18,
                    right: 18,
                    top: 20,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 5,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        SizedBox(height: 20),

                        Text(
                          "Add New Product",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 20),

                        Form(
                          key: _vmn.customerAddFormKey,
                          child: Column(
                            children: [
                              CustomPakkaFormField(
                                controller: _vmn.productNameController,
                                label: "Product Name *",
                                validator: (value) =>
                                    Validation.validateName(value, context),
                                textInputAction: TextInputAction.next,
                              ),

                              SizedBox(height: 12),

                              CustomPakkaFormField(
                                controller: _vmn.productPriceController,
                                label: "Product Purchase Price",
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: 12),

                              CustomPakkaFormField(
                                controller: _vmn.productSellPriceController,
                                label: "Product Sell Price",
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: 12),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 19,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  color: AppColors.fillColor,
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Text(
                                  "Product Stock-In : ${_vm.selectedManufacturingDate}",
                                  style: AppTextStyle.bodyMediumSecondary,
                                ),
                              ),

                              SizedBox(height: 12),

                              CustomPakkaFormField(
                                controller: _vmn.productStockController,
                                label: "Product Stock",
                                textInputAction: TextInputAction.done,
                                onComplete: () async {
                                  if (_vmn.customerAddFormKey.currentState!
                                      .validate()) {
                                    await _vmn.addSupplier(context);

                                    /// refresh dropdown list
                                  }
                                },
                              ),
                              SizedBox(height: 12),

                              CustomPakkaFormField(
                                controller: _vmn.productCodeController,
                                label: "Product Code",
                                textInputAction: TextInputAction.done,
                                onComplete: () async {
                                  if (_vmn.customerAddFormKey.currentState!
                                      .validate()) {
                                    await _vmn.addSupplier(context);

                                    /// refresh dropdown list
                                    ref.invalidate(supplierListProvider);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              if (_vmn.customerAddFormKey.currentState!
                                  .validate()) {
                                await _vmn.addProduct(context);

                                /// reload supplier list
                              }
                            },
                            child: Text(
                              "Save Product",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                if (_vm.isLoading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withAlpha(25),
                      child: Center(
                        child: loader, // your custom loader
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
