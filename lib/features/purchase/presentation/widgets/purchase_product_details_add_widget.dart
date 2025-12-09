import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/core/global_widgets/custom_pakka_form_field.dart';
import 'package:pakkahishab/features/purchase/data/models/all_product_model.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_add_viewmodel.dart';

class PurchaseProductDetailsAddWidget extends StatelessWidget {
  final AllProduct? selectedProductAll;
  final AddProductItem? selectedProductAdd;

  const PurchaseProductDetailsAddWidget({
    super.key,
    this.selectedProductAll,
    this.selectedProductAdd
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBack(title: "Add Product To Purchase"),

      body: Consumer(
        builder: (context, ref, child) {
          final _vm = ref.watch(purchaseAddViewModelProvider);
          final _vmn = ref.watch(purchaseAddViewModelProvider.notifier);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(height: 20),
            
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 19),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: AppColors.fillColor,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text(
                    "price : ${_vmn.selectedPurchaseProductName}",
                    style: AppTextStyle.bodyMediumSecondary,
                  ),
                ),
                SizedBox(height: 10),
            
                CustomPakkaFormField(
                  controller: _vmn.purchaseProductQuantity,
                  label: "Quantity",
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 19),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: AppColors.fillColor,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text(
                    "price : ${_vmn.selectedPurchaseProductPrice}",
                    style: AppTextStyle.bodyMediumSecondary,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
