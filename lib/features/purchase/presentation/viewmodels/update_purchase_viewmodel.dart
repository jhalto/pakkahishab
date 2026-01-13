import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/core/utils/show_snackbar.dart';
import 'package:pakkahishab/features/purchase/data/models/all_product_model.dart';
import 'package:pakkahishab/features/purchase/data/models/purchase_detail_model.dart';
import 'package:pakkahishab/features/purchase/data/repositories/purchase_repository.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_add_viewmodel.dart';

final purchaseUpdateViewModel =
    NotifierProvider<PurchaseUpdateNotifier, PurchaseUpdateState>(
      () => PurchaseUpdateNotifier(),
    );

class PurchaseUpdateState {
  final bool isLoading;
  final String? selectedManufacturingDate;
  final String? selectedExpiredDate;
  final List<PurchaseDetailsProduct>? selectedPurchaseProducts;

  PurchaseUpdateState({
    this.isLoading = false,
    String? selectedManufacturingDate,
    String? selectedExpiredDate,
    this.selectedPurchaseProducts,
  }) : selectedManufacturingDate =
           selectedManufacturingDate ??
           DateFormat('yyyy-MM-dd').format(DateTime.now()),
       selectedExpiredDate =
           selectedExpiredDate ??
           DateFormat('yyyy-MM-dd').format(DateTime.now());

  PurchaseUpdateState copyWith({
    bool? isLoading,
    String? selectedManufacturingDate,
    String? selectedExpiredDate,
    List<PurchaseDetailsProduct>? selectedPurchaseProducts,
  }) {
    return PurchaseUpdateState(
      isLoading: isLoading ?? this.isLoading,
      selectedExpiredDate: selectedExpiredDate ?? this.selectedExpiredDate,
      selectedManufacturingDate:
          selectedManufacturingDate ?? this.selectedManufacturingDate,
      selectedPurchaseProducts:
          selectedPurchaseProducts ?? this.selectedPurchaseProducts,
    );
  }
}

class PurchaseUpdateNotifier extends Notifier<PurchaseUpdateState> {
  late final PurchaseRepository _repo;

  @override
  build() {
    _repo = ref.read(purchaseRepositoryProvider);
    return PurchaseUpdateState();
  }
  // update supplier view model

  final TextEditingController updateSupplierName = TextEditingController();
  final TextEditingController updateSupplierPhone = TextEditingController();
  final TextEditingController updateSupplierEmail = TextEditingController();
  final TextEditingController updateSupplierAddress = TextEditingController();
  final TextEditingController updateSupplierOpeningBalance =
      TextEditingController();
  // product update form key

  final productUpdateFormKey = GlobalKey<FormState>();

  // product update controllers
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productSellPriceController = TextEditingController();
  TextEditingController productCodeController = TextEditingController();
  TextEditingController productStockController = TextEditingController();

  // purchase product add controllers and variable

  TextEditingController purchaseProductQuantity = TextEditingController(
    text: 1.toString(),
  );
  String selectedPurchaseProductName = '';
  String selectedPurchaseProductPrice = '';
  String selectedPurchaseProductId = '';

  // state update method

  void updateManufacturingDate({required String date}) {
    state = state.copyWith(selectedManufacturingDate: date);
  }

  void updateExpireDate({required String expireDate}) {
    state = state.copyWith(selectedExpiredDate: expireDate);
  }

  Future<void> updateProduct(
    BuildContext context, {
    required String productId,
  }) async {
    state = state.copyWith(isLoading: true);
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    print(phone);
    print(pin);
    print(code);

    final List<AddProductItem> productList = [
      AddProductItem(
        productId: productId,
        name: productNameController.text.trim(),
        purchasePrice: double.tryParse(productPriceController.text.trim()) ?? 0,
        sellPrice: double.tryParse(productSellPriceController.text.trim()) ?? 0,
        manufacturingDate: state.selectedManufacturingDate.toString(),
        expiredDate: state.selectedManufacturingDate.toString(),
        productStock: int.tryParse(productStockController.text.trim()) ?? 0,
      ),
    ];

    try {
      final response = await _repo.updateProduct(
        code: code.toString(),
        mobile: phone.toString(),
        pin: pin.toString(),
        product: productList,
      );

      print(" response is : $response");
      state = state.copyWith(isLoading: false);
      if (response['data']['status'] == 'success') {
        state = state.copyWith(isLoading: false);

        if (!context.mounted) return;
        FocusScope.of(context).unfocus();
        Navigator.pop(context);
        print("successful");

        showCustomSnackBar(
          context,
          "Products updated successfully",
          type: SnackBarType.success,
        );

        ref.invalidate(productListProvider);
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

  Future<void> updateSupplier(
    BuildContext context, {
    required String supplierId,
  }) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    final supplier = {
      "supplier_id": supplierId,
      "supplier_name": updateSupplierName.text.trim(),
      "phone": updateSupplierPhone.text.trim(),
      "address": updateSupplierAddress.text.trim(),
      "email": updateSupplierEmail.text.trim(),
      "godown_no": "1",
      "opening_balance": updateSupplierOpeningBalance.text.trim(),
    };

    final response = await _repo.updateSupplier(
      code: code.toString(),
      mobile: phone.toString(),
      pin: pin.toString(),
      supplier: supplier,
    );
    print(response);

    if (response['status'] == 'success') {
      if (!context.mounted) return;
      Navigator.pop(context);
      if (!context.mounted) return;
      showCustomSnackBar(
        context,
        "Suppliers updated successfully",
        type: SnackBarType.success,
      );

      ref.invalidate(supplierListProvider);
    } else {
      if (!context.mounted) return;
      showCustomSnackBar(context, response['message']);
    }
  }

 void loadPurchaseEditProduct(List<PurchaseDetailsProduct> products) {
  state = state.copyWith(
    selectedPurchaseProducts: [...products],
  );
}

  void calculatePurchaseAmounts() {
    final products = state.selectedPurchaseProducts ?? [];

    final calculatedNetAmount = products.fold<double>(
      0.0,
      (sum, item) => sum + (item.unitPrice * item.quantity),
    );

    // ✅ ALWAYS update net amount
    // state = state.copyWith(
    //   purchaseNetAmount: calculatedNetAmount.toStringAsFixed(0),
    //   purchaseTotalAmount: calculatedNetAmount.toStringAsFixed(0),
    // );
  }

  Future<void> addProductInPurchaseList(BuildContext context) async {
    final existingProducts = state.selectedPurchaseProducts ?? [];

    final newProduct = PurchaseDetailsProduct(
      productId: selectedPurchaseProductId,
      productName: selectedPurchaseProductName,
      unitPrice: double.tryParse(selectedPurchaseProductPrice) ?? 0,
      quantity: int.tryParse(purchaseProductQuantity.text) ?? 0,
    );

    // ✅ FIX: compare productId with productId
    final index = existingProducts.indexWhere(
      (item) => item.productId == newProduct.productId,
    );

    List<PurchaseDetailsProduct> updatedProducts;

    if (index != -1) {
      final existing = existingProducts[index];

      final updatedItem = PurchaseDetailsProduct(
        productId: existing.productId,
        productName: existing.productName,
        unitPrice: existing.unitPrice,
        quantity: newProduct.quantity, // replace quantity
      );

      updatedProducts = [...existingProducts];
      updatedProducts[index] = updatedItem;
    } else {
      updatedProducts = [...existingProducts, newProduct];
    }

    // ✅ Update state
    state = state.copyWith(selectedPurchaseProducts: updatedProducts);

    // ✅ Recalculate amounts
    calculatePurchaseAmounts();

    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
