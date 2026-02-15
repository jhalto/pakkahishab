import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/core/global_widgets/custom_fullwidth_button.dart';
import 'package:pakkahishab/core/global_widgets/custom_pakka_form_field.dart';
import 'package:pakkahishab/features/sales/data/models/sales_product_model.dart';
import 'package:pakkahishab/features/sales/presentation/viewmodels/sales_add_viewmodel.dart';

class SaleProductDetailsAddWidget extends StatelessWidget {
  final AllProduct? selectedProductAll;
  final AddProductItem? selectedProductAdd;
  final SaleDetailsProduct? selectedSaleDetailProduct;

  const SaleProductDetailsAddWidget({
    super.key,
    this.selectedProductAll,
    this.selectedProductAdd,
    this.selectedSaleDetailProduct
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBack(title: "Add Product To Sell"),

      body: Consumer(
        builder: (context, ref, child) {
          final vm = ref.watch(saleAddViewModelProvider);
          final vmn = ref.watch(saleAddViewModelProvider.notifier);

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
                    "price : ${vmn.selectedSaleProductName}",
                    style: AppTextStyle.bodyMediumSecondary,
                  ),
                ),
                SizedBox(height: 10),
            
                CustomPakkaFormField(
                  controller: vmn.saleProductQuantity,
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
                    "price : ${vmn.selectedSaleProductPrice}",
                    style: AppTextStyle.bodyMediumSecondary,
                  ),
                ),
                SizedBox(height: 100,),

                CustomFullwidthButton(onTap: ()async{
                  vmn.addProductInSaleList(context);
                }, title: "Add")
              ],
            ),
          );
        },
      ),
    );
  }
}
