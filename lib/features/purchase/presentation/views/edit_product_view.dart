import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/core/global_widgets/custom_pakka_form_field.dart';
import 'package:pakkahishab/core/helper/date_picker_helper.dart';
import 'package:pakkahishab/core/helper/validation_helper.dart';
import 'package:pakkahishab/core/utils/loader.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_add_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/update_purchase_viewmodel.dart';

class EditProductView extends StatelessWidget {
 final String productId;
  const EditProductView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBack(title: "Edit Product"),
      body: Consumer(
        builder: (context, ref, _) {
          final _vm = ref.watch(purchaseUpdateViewModel); // <- watch here
          final _vmn = ref.watch(purchaseUpdateViewModel.notifier);
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
                      Form(
                        key: _vmn.productUpdateFormKey,
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
                            InkWell(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              onTap: () async {
                                final date = await pickDate(context: context);
                                if (date != null) {
                                  _vmn.updateManufacturingDate(date: date);
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
                                      "Product Stock-In : ${_vm.selectedManufacturingDate}",
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
                                final date = await pickDate(context: context);
                                if (date != null) {
                                  _vmn.updateExpireDate(expireDate: date);
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
                                      "Product Expire-In : ${_vm.selectedExpiredDate}",
                                      style: AppTextStyle.bodyMediumSecondary,
                                    ),
                                    Icon(Icons.calendar_today_outlined),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 12),

                            CustomPakkaFormField(
                              controller: _vmn.productStockController,
                              label: "Product Stock",
                              textInputAction: TextInputAction.done,
                              onComplete: () async {
                                print("product is: $productId");
                                if (_vmn.productUpdateFormKey.currentState!
                                    .validate()) {
                                  await _vmn.updateProduct(context,productId: productId);

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
                            if (_vmn.productUpdateFormKey.currentState!
                                .validate()) {
                              await _vmn.updateProduct(context, productId: productId);

                              /// reload supplier list
                            }
                          },
                          child: Text(
                            "Save Product",
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
      ),
    );
  }
}
