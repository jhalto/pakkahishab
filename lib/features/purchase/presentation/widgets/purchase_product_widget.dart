import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/global_widgets/custom_button.dart';
import 'package:pakkahishab/core/global_widgets/custom_pakka_form_field.dart';
import 'package:pakkahishab/core/helper/validation_helper.dart';
import 'package:pakkahishab/core/utils/loader.dart';
import 'package:pakkahishab/features/purchase/data/models/all_product_model.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_add_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_product_details_add_widget.dart';

class PurchaseProductWidget extends ConsumerWidget {
  const PurchaseProductWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _vm = ref.watch(purchaseAddViewModelProvider);
    final _vmn = ref.watch(purchaseAddViewModelProvider.notifier);

    final supplierAsync = ref.watch(productListProvider);

    return supplierAsync.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, st) => Text("Failed to load products"),

      data: (allSuppliers) {
        return Row(
          children: [
            SizedBox(width: 10),

            /// ------------------ DROPDOWN ------------------
            Expanded(
              child: DropdownSearch<AllProduct>(
                items: (filter, loadProps) async => allSuppliers,

                filterFn: (product, filter) => product.productName
                    .toLowerCase()
                    .contains(filter.toLowerCase()),

                itemAsString: (s) => s.productName,

                compareFn: (a, b) => a.productId == b.productId,

                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      hintText: "Search Product...",
                      prefixIcon: Icon(Icons.search),
                      filled: true,

                      fillColor: Colors.grey.shade100,
                      border: InputBorder.none,
                    ),
                  ),
                  emptyBuilder: (context, searchEntry) {
                    // This shows when no item matches the search
                    return ListTile(
                      title: Text("No product found"),
                      trailing: CustomButton(
                        title: "Add Product",
                        onTap: () {
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
                                  final _vmn = ref.watch(
                                    purchaseAddViewModelProvider.notifier,
                                  );
                                  return Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(
                                            context,
                                          ).viewInsets.bottom,
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
                                                  borderRadius:
                                                      BorderRadius.circular(20),
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
                                                      controller: _vmn
                                                          .productNameController,
                                                      label: "Product Name *",
                                                      validator: (value) =>
                                                          Validation.validateName(
                                                            value,
                                                            context,
                                                          ),
                                                      textInputAction:
                                                          TextInputAction.next,
                                                    ),

                                                    SizedBox(height: 12),

                                                    CustomPakkaFormField(
                                                      controller: _vmn
                                                          .productPriceController,
                                                      label:
                                                          "Product Purchase Price",
                                                      textInputAction:
                                                          TextInputAction.next,
                                                    ),
                                                    SizedBox(height: 12),

                                                    CustomPakkaFormField(
                                                      controller: _vmn
                                                          .productSellPriceController,
                                                      label:
                                                          "Product Sell Price",
                                                      textInputAction:
                                                          TextInputAction.next,
                                                    ),
                                                    SizedBox(height: 12),
                                                    Container(
                                                      width: double.infinity,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            vertical: 14,
                                                            horizontal: 19,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                              Radius.circular(
                                                                8,
                                                              ),
                                                            ),
                                                        color:
                                                            AppColors.fillColor,
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        "Product Stock-In : ${_vm.selectedManufacturingDate}",
                                                        style: AppTextStyle
                                                            .bodyMediumSecondary,
                                                      ),
                                                    ),

                                                    SizedBox(height: 12),

                                                    CustomPakkaFormField(
                                                      controller: _vmn
                                                          .productStockController,
                                                      label: "Product Stock",
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      onComplete: () async {
                                                        if (_vmn
                                                            .customerAddFormKey
                                                            .currentState!
                                                            .validate()) {
                                                          await _vmn
                                                              .addSupplier(
                                                                context,
                                                              );

                                                          /// refresh dropdown list
                                                        }
                                                      },
                                                    ),
                                                    SizedBox(height: 12),

                                                    CustomPakkaFormField(
                                                      controller: _vmn
                                                          .productCodeController,
                                                      label: "Product Code",
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      onComplete: () async {
                                                        if (_vmn
                                                            .customerAddFormKey
                                                            .currentState!
                                                            .validate()) {
                                                          await _vmn
                                                              .addSupplier(
                                                                context,
                                                              );

                                                          /// refresh dropdown list
                                                          ref.invalidate(
                                                            supplierListProvider,
                                                          );
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
                                                    backgroundColor:
                                                        AppColors.primaryColor,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          vertical: 14,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    if (_vmn
                                                        .customerAddFormKey
                                                        .currentState!
                                                        .validate()) {
                                                      await _vmn.addProduct(
                                                        context,
                                                      );

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
                                              child:
                                                  loader, // your custom loader
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.add, color: AppColors.whiteColor),
                      ),
                    );
                  },
                ),

                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    labelText: "Add Product (Optional)",
                    filled: true,
                    contentPadding: EdgeInsets.zero,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),

                onChanged: (value) {
                  if (value != null) {
                    _vmn.selectedPurchaseProductName = value.productName;
                    _vmn.selectedPurchaseProductPrice = value.purchasePrice.toString();
                     Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseProductDetailsAddWidget(selectedProductAll: value),));
                  }
                },
              ),
            ),

            SizedBox(width: 10),

            /// ------------------ ADD SUPPLIER BUTTON ------------------
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
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
                        final _vmn = ref.watch(
                          purchaseAddViewModelProvider.notifier,
                        );
                        return Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(
                                  context,
                                ).viewInsets.bottom,
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
                                            controller:
                                                _vmn.productNameController,
                                            label: "Product Name *",
                                            validator: (value) =>
                                                Validation.validateName(
                                                  value,
                                                  context,
                                                ),
                                            textInputAction:
                                                TextInputAction.next,
                                          ),

                                          SizedBox(height: 12),

                                          CustomPakkaFormField(
                                            controller:
                                                _vmn.productPriceController,
                                            label: "Product Purchase Price",
                                            textInputAction:
                                                TextInputAction.next,
                                          ),
                                          SizedBox(height: 12),

                                          CustomPakkaFormField(
                                            controller:
                                                _vmn.productSellPriceController,
                                            label: "Product Sell Price",
                                            textInputAction:
                                                TextInputAction.next,
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
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            child: Text(
                                              "Product Stock-In : ${_vm.selectedManufacturingDate}",
                                              style: AppTextStyle
                                                  .bodyMediumSecondary,
                                            ),
                                          ),

                                          SizedBox(height: 12),

                                          CustomPakkaFormField(
                                            controller:
                                                _vmn.productStockController,
                                            label: "Product Stock",
                                            textInputAction:
                                                TextInputAction.done,
                                            onComplete: () async {
                                              if (_vmn
                                                  .customerAddFormKey
                                                  .currentState!
                                                  .validate()) {
                                                await _vmn.addSupplier(context);

                                                /// refresh dropdown list
                                              }
                                            },
                                          ),
                                          SizedBox(height: 12),

                                          CustomPakkaFormField(
                                            controller:
                                                _vmn.productCodeController,
                                            label: "Product Code",
                                            textInputAction:
                                                TextInputAction.done,
                                            onComplete: () async {
                                              if (_vmn
                                                  .customerAddFormKey
                                                  .currentState!
                                                  .validate()) {
                                                await _vmn.addSupplier(context);

                                                /// refresh dropdown list
                                                ref.invalidate(
                                                  supplierListProvider,
                                                );
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
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (_vmn
                                              .customerAddFormKey
                                              .currentState!
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
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(14),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),

            SizedBox(width: 10),
          ],
        );
      },
    );
  }
}
