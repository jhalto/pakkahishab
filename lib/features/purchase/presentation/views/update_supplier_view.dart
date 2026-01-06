import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/core/global_widgets/custom_pakka_form_field.dart';
import 'package:pakkahishab/core/helper/validation_helper.dart';
import 'package:pakkahishab/core/utils/loader.dart';
import 'package:pakkahishab/features/purchase/data/models/all_supplier_model.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_add_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/update_purchase_viewmodel.dart';

class UpdateSupplierView extends StatelessWidget {
  final AllSupplier supplier;
  const UpdateSupplierView({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBack(title: "Update Supplier"),
      body: Consumer(
        builder: (context, ref, child) {
          final _vm = ref.watch(purchaseUpdateViewModel);
          final _vmn = ref.watch(purchaseUpdateViewModel.notifier);
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),

                      Form(
                        // key: _vmn.customerAddFormKey,
                        child: Column(
                          children: [
                            CustomPakkaFormField(
                              controller: _vmn.updateSupplierName,
                              label: "Supplier Name *",
                              validator: (value) =>
                                  Validation.validateName(value, context),
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 12),

                            CustomPakkaFormField(
                              controller: _vmn.updateSupplierPhone,
                              label: "Supplier Phone *",
                              validator: (value) =>
                                  Validation.validatePhone(value, context),
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 12),

                            CustomPakkaFormField(
                              controller: _vmn.updateSupplierEmail,
                              label: "Supplier Email",
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 12),

                            CustomPakkaFormField(
                              controller: _vmn.updateSupplierAddress,
                              label: "Supplier Address",
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 12),

                            CustomPakkaFormField(
                              controller: _vmn.updateSupplierOpeningBalance,
                              label: "Supplier Opening Balance",
                              textInputAction: TextInputAction.done,
                              onComplete: () async {
                                // if (_vmn.customerAddFormKey.currentState!
                                //     .validate()) {
                                //   await _vmn.addSupplier(context);

                                //   /// refresh dropdown list
                                //   ref.invalidate(supplierListProvider);
                                // }
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
                            // if (_vmn.customerAddFormKey.currentState!.validate()) {
                            //   await _vmn.addSupplier(context);

                            //   /// reload supplier list
                            //   ref.invalidate(supplierListProvider);
                            // }

                            _vmn.updateSupplier(
                              context,
                              supplierId: supplier.supplierId,
                            );
                          },
                          child: Text(
                            "Update Supplier",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              if (_vm.isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.grey.withAlpha(10),
                    width: double.infinity,
                    height: double.infinity,

                    child: Center(child: loader),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
