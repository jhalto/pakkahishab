import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
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
  final String? selectedExpiredDate;
  final String? supplierId;
  final List<PurchaseDetailsProduct>? selectedPurchaseProducts;

  PurchaseAddState({
    this.isLoading = false,

    String? selectedManufacturingDate,
    this.selectedExpiredDate,
    this.errorMessage,
    this.supplierId,
    this.selectedPurchaseProducts,
  }) : selectedManufacturingDate =
           selectedManufacturingDate ??
           DateFormat('yyyy-MM-dd').format(DateTime.now());

  PurchaseAddState copyWith({
    bool? isLoading,
    String? selectedManufacturingDate,
    String? selectedExpiredDate,
    String? errorMessage,
    String? supplierId,
    List<PurchaseDetailsProduct>? selectedPurchaseProducts,
  }) {
    return PurchaseAddState(
      isLoading: isLoading ?? this.isLoading,
      selectedManufacturingDate:
          selectedManufacturingDate ?? this.selectedManufacturingDate,
      selectedExpiredDate: selectedExpiredDate ?? this.selectedExpiredDate,

      errorMessage: errorMessage ?? this.errorMessage,
      supplierId: supplierId ?? this.supplierId,
      selectedPurchaseProducts: selectedPurchaseProducts ?? selectedPurchaseProducts
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
  

  void clearProductAddController(){
   productCodeController.clear();
   productNameController.clear();
   productSellPriceController.clear();
   productStockController.clear();
   productPriceController.clear(); 
  }
  // purchase product add controllers and variable

  TextEditingController purchaseProductQuantity = TextEditingController(text: 1.toString());
  String selectedPurchaseProductName = '';
  String selectedPurchaseProductPrice = '';
  String selectedPurchaseProductId = '';
  

  
  // TextEditingController purchaseProductQuantity = TextEditingController();

  final customerAddFormKey = GlobalKey<FormState>();

  @override
  PurchaseAddState build() {
    _repo = ref.read(purchaseRepositoryProvider);
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
        response['data']['message'] == 'Suppliers inserted successfully') {
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

    try {
      final response = await _repo.addProduct(
        code: code.toString(),
        mobile: phone.toString(),
        pin: pin.toString(),
        product: productList,
      );
      print(response);
      if (response['statusCode'] == 200 && response['data']['status'] == 'success') {
        
        state = state.copyWith(isLoading: false);
        
        if (!context.mounted) return;
        FocusScope.of(context).unfocus();
        Navigator.pop(context);

        showCustomSnackBar(context, "Products inserted successfully", type: SnackBarType.success);
        
        selectedPurchaseProductName = productList.first.name;
        selectedPurchaseProductPrice = productList.first.purchasePrice.toString();
        // selectedPurchaseProductId = productList.first.;
        
        Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseProductDetailsAddWidget(selectedProductAdd: productList.first),));
        ref.invalidate(productListProvider);
        clearProductAddController();
      }else if(response['data']['status'] == 'error'){
         state = state.copyWith(isLoading: false);
         if(!context.mounted) return;
         showCustomSnackBar(context, response['data']['message']);

      }
    } catch (e) {
       state = state.copyWith(isLoading: false);
      print(e);
    }
  } 

  
  
}
