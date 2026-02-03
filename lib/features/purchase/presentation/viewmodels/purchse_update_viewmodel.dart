import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/global_widgets/custom_pakka_form_field.dart';
import 'package:pakkahishab/core/helper/date_picker_helper.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/core/helper/validation_helper.dart';
import 'package:pakkahishab/core/utils/loader.dart';
import 'package:pakkahishab/core/utils/show_snackbar.dart';
import 'package:pakkahishab/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:pakkahishab/features/purchase/data/models/all_product_model.dart';
import 'package:pakkahishab/features/purchase/data/repositories/purchase_repository.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_add_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_supplier_wise_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_edit_widgets/edit_purchase_product_details_widget.dart';
import 'package:pakkahishab/features/supplier/presentation/viewmodels/supplier_viewmodel.dart';

final purchaseUpdateViewModel =
    NotifierProvider<PurchaseUpdateNotifier, PurchaseUpdateState>(
      () => PurchaseUpdateNotifier(),
    );

class PurchaseUpdateState {
  final bool isLoading;
  final bool editLoading;
  final String? selectedManufacturingDate;
  final String? selectedExpiredDate;
  final String? purchaseNetAmount;
  final List<PurchaseDetailsProduct>? selectedPurchaseProducts;

  PurchaseUpdateState({
    this.isLoading = false,
    this.editLoading = false,
    String? selectedManufacturingDate,
    String? selectedExpiredDate,
    this.purchaseNetAmount,
    this.selectedPurchaseProducts,
  }) : selectedManufacturingDate =
           selectedManufacturingDate ??
           DateFormat('yyyy-MM-dd').format(DateTime.now()),
       selectedExpiredDate =
           selectedExpiredDate ??
           DateFormat('yyyy-MM-dd').format(DateTime.now());

  PurchaseUpdateState copyWith({
    bool? isLoading,
    bool? editLoading,
    String? selectedManufacturingDate,
    String? selectedExpiredDate,
    String? purchaseNetAmount,
    List<PurchaseDetailsProduct>? selectedPurchaseProducts,
  }) {
    return PurchaseUpdateState(
      isLoading: isLoading ?? this.isLoading,
      editLoading: editLoading ?? this.editLoading,
      selectedExpiredDate: selectedExpiredDate ?? this.selectedExpiredDate,
      selectedManufacturingDate:
          selectedManufacturingDate ?? this.selectedManufacturingDate,
      selectedPurchaseProducts:
          selectedPurchaseProducts ?? this.selectedPurchaseProducts,
      purchaseNetAmount: purchaseNetAmount ?? this.purchaseNetAmount,
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
  final productAddFormKey = GlobalKey<FormState>();

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
    state = state.copyWith(selectedPurchaseProducts: products);
    calculatePurchaseAmounts();
  }

  void calculatePurchaseAmounts() {
    final products = state.selectedPurchaseProducts ?? [];

    final calculatedNetAmount = products.fold<double>(
      0.0,
      (sum, item) => sum + (item.unitPrice * item.quantity),
    );

    // ✅ ALWAYS update net amount
    state = state.copyWith(
      purchaseNetAmount: calculatedNetAmount.toStringAsFixed(0),
      // purchaseTotalAmount: calculatedNetAmount.toStringAsFixed(0),
    );
  }

  void updateDueAmount(String value) {
    state = state.copyWith(purchaseNetAmount: value);
  }

  Future<void> addProductInEditPurchaseList(BuildContext context) async {
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
        purchaseDetailId: existing.purchaseDetailId,
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
        purchasePrice: double.tryParse(productPriceController.text.trim()) ?? 0,
        sellPrice: double.tryParse(productSellPriceController.text.trim()) ?? 0,
        manufacturingDate: state.selectedManufacturingDate.toString(),
        expiredDate: state.selectedManufacturingDate.toString(),
        productStock: int.tryParse(productStockController.text.trim()) ?? 0,
      ),
    ];

    try {
      final response = await _repo.addProduct(
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
          "Products inserted successfully",
          type: SnackBarType.success,
        );
        selectedPurchaseProductId =
            response['data']['inserted_products'][0]['product_id'].toString();
        selectedPurchaseProductName = productList.first.name;
        selectedPurchaseProductPrice = productList.first.purchasePrice
            .toString();
        purchaseProductQuantity.text = "1";

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditPurchaseProductDetailsAddWidget(
              selectedProductAdd: productList.first,
            ),
          ),
        );
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

  void clearProductAddController() {
    productCodeController.clear();
    productNameController.clear();
    productPriceController.clear();
    productSellPriceController.clear();
    productStockController.clear();
  }

  Future<void> updatePurchase(
    BuildContext context, {
    required String purchaseId,
    required String purchaseNo,
  }) async {
    state = state.copyWith(editLoading: true);
    print("Purchase id:  $purchaseId");
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    // final purchaseTypeValue = int.tryParse(
    //   state.purchaseType == 'Credit' ? "0" : "1",
    // );

    // Safe product list (empty allowed)
    final productList = (state.selectedPurchaseProducts ?? [])
        .map(
          (p) => {
            if (p.purchaseDetailId != null)
              "purchase_detail_id": p.purchaseDetailId,
            "product_id": int.tryParse(p.productId) ?? 0,
            "quantity": p.quantity,
            "unit_price": p.unitPrice,
          },
        )
        .toList();

    // 🔥 IMPORTANT: await
    final response = await _repo.updatePurchase(
      purchaseId: purchaseId,
      mobile: phone ?? "",
      password: pin ?? "",
      schoolCode: code ?? "",
      productList: productList, // works even when empty
    );

    print(response);

    if (response['data']['status'] == 'success') {
      state = state.copyWith(editLoading: false);

      if (!context.mounted) return;

      showCustomSnackBar(
        context,
        "Purchase Updated Successfully",
        type: SnackBarType.success,
      );

      await ref
          .read(purchaseViewModelProvider.notifier)
          .fetchPurchaseDetails(purchaseNo: purchaseNo);
      if (!context.mounted) return;
      Navigator.pop(context);

      ref.read(purchaseViewModelProvider.notifier).fetchPurchases();
      ref
          .read(purchaseSupplierWiseViewModel.notifier)
          .fetchSupplierWisePurchases();
      ref.read(homeProvider.notifier).fetchDashBoard('ALL');

      // ref
      //     .read(purchaseViewModelProvider.notifier)
      //     .fetchPurchaseDetails(purchaseNo: purchaseNo);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => PurchasePaymentView()),
      // );
      // Navigator.pop(context);
      // clearPurchaseRecord();
      // ref.read(purchaseViewModelProvider.notifier).fetchSupplierWisePurchases();
      // ref.read(homeProvider.notifier).fetchDashBoard('YEAR');
    } else if (response['data']['status'] == 'error') {
      state = state.copyWith(editLoading: false);
      if (!context.mounted) return;
      showCustomSnackBar(context, response['data']['message']);
    }
  }

  Future<void> updatePurchaseForDelete(
    BuildContext context, {
    required String purchaseId,
    required String purchaseNo,
  }) async {
    state = state.copyWith(editLoading: true);
    print("Purchase id:  $purchaseId");
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    // final purchaseTypeValue = int.tryParse(
    //   state.purchaseType == 'Credit' ? "0" : "1",
    // );

    // Safe product list (empty allowed)
    final productList = (state.selectedPurchaseProducts ?? [])
        .map(
          (p) => {
            if (p.purchaseDetailId != null)
              "purchase_detail_id": p.purchaseDetailId,
            "product_id": int.tryParse(p.productId) ?? 0,
            "quantity": p.quantity,
            "unit_price": p.unitPrice,
          },
        )
        .toList();

    // 🔥 IMPORTANT: await
    final response = await _repo.updatePurchase(
      purchaseId: purchaseId,
      mobile: phone ?? "",
      password: pin ?? "",
      schoolCode: code ?? "",
      productList: productList, // works even when empty
    );

    print(response);

    if (response['data']['status'] == 'success') {
      state = state.copyWith(editLoading: false);

      if (!context.mounted) return;

      showCustomSnackBar(
        context,
        "Purchase Updated Successfully",
        type: SnackBarType.success,
      );
      // Navigator.pop(context);
      await ref
          .read(purchaseViewModelProvider.notifier)
          .fetchPurchaseDetails(purchaseNo: purchaseNo);
      if (!context.mounted) return;

      ref.read(purchaseViewModelProvider.notifier).fetchPurchases();
      ref
          .read(purchaseSupplierWiseViewModel.notifier)
          .fetchSupplierWisePurchases();
      ref.read(homeProvider.notifier).fetchDashBoard('ALL');

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => PurchasePaymentView()),
      // );
      // Navigator.pop(context);
      // clearPurchaseRecord();
      // ref.read(purchaseViewModelProvider.notifier).fetchSupplierWisePurchases();
      // ref.read(homeProvider.notifier).fetchDashBoard('YEAR');
    } else if (response['data']['status'] == 'error') {
      state = state.copyWith(editLoading: false);
      if (!context.mounted) return;
      showCustomSnackBar(context, response['data']['message']);
    }
  }

  Future<void> deleteProductFromPurchase(
    BuildContext context, {
    required String purchaseId,
    required int index,
    required String purchaseNo,
  }) async {
    final products = <PurchaseDetailsProduct>[
      ...?state.selectedPurchaseProducts,
    ];

    final product = products[index];
    if (products.length <= 1) {
      showCustomSnackBar(
        context,
        "Please select another item first to Delete it",
      );
      return;
    }
    // ✅ CASE 1: Local product (NO purchaseDetailId) → remove locally
    if (product.purchaseDetailId == null) {
      products.removeAt(index);

      state = state.copyWith(selectedPurchaseProducts: products);
      calculatePurchaseAmounts();
      updatePurchaseForDelete(
        context,
        purchaseId: purchaseId,
        purchaseNo: purchaseNo,
      );
      return;
    }

    // ✅ CASE 2: Server product → call API
    state = state.copyWith(editLoading: true);

    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    final response = await _repo.deleteProductFromPurchase(
      phone: phone.toString(),
      pin: pin.toString(),
      code: code.toString(),
      purchaseId: purchaseId,
      productDetailId: product.purchaseDetailId!,
    );

    state = state.copyWith(editLoading: false);

    if (response['status'] == 'success') {
      products.removeAt(index);

      state = state.copyWith(selectedPurchaseProducts: products);
      calculatePurchaseAmounts();

      if (!context.mounted) return;
      updatePurchaseForDelete(
        context,
        purchaseId: purchaseId,
        purchaseNo: purchaseNo,
      );
      showCustomSnackBar(
        context,
        "Purchase updated",
        type: SnackBarType.success,
      );
    }
  }

  Future<void> showProductAddBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            final vm = ref.watch(purchaseUpdateViewModel); // <- watch here
            final vmn = ref.watch(purchaseUpdateViewModel.notifier);
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
                          key: vmn.productAddFormKey,
                          child: Column(
                            children: [
                              CustomPakkaFormField(
                                controller: vmn.productNameController,
                                label: "Product Name *",
                                validator: (value) =>
                                    Validation.validateName(value, context),
                                textInputAction: TextInputAction.next,
                              ),

                              SizedBox(height: 12),

                              CustomPakkaFormField(
                                controller: vmn.productPriceController,
                                label: "Product Purchase Price",
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: 12),

                              CustomPakkaFormField(
                                controller: vmn.productSellPriceController,
                                label: "Product Sell Price",
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: 12),
                              InkWell(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                onTap: () async {
                                  final date = await pickDateAsString(context: context);
                                  if (date != null) {
                                    updateManufacturingDate(date: date);
                                  }
                                },
                                child: Ink(
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
                                  child: Row(
                                    mainAxisAlignment: .spaceBetween,
                                    children: [
                                      Text(
                                        "Product Stock-In : ${vm.selectedManufacturingDate}",
                                        style: AppTextStyle.bodyMediumSecondary,
                                      ),
                                      Icon(Icons.calendar_today_outlined),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              InkWell(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                onTap: () async {
                                  final date = await pickDateAsString(context: context);
                                  if (date != null) {
                                    updateExpireDate(expireDate: date);
                                  }
                                },
                                child: Ink(
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
                                  child: Row(
                                    mainAxisAlignment: .spaceBetween,
                                    children: [
                                      Text(
                                        "Product Expire-In : ${vm.selectedExpiredDate}",
                                        style: AppTextStyle.bodyMediumSecondary,
                                      ),
                                      Icon(Icons.calendar_today_outlined),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 12),

                              CustomPakkaFormField(
                                controller: vmn.productStockController,
                                label: "Product Stock",
                                textInputAction: TextInputAction.done,
                                onComplete: () async {
                                  if (vmn.productAddFormKey.currentState!
                                      .validate()) {
                                    await vmn.addProduct(context);

                                    /// reload supplier list
                                  }
                                },
                              ),
                              SizedBox(height: 12),
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
                              if (vmn.productAddFormKey.currentState!
                                  .validate()) {
                                await vmn.addProduct(context);

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
                if (vm.isLoading)
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
