import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/helper/navigation_helper.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_return_viewmodel.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_edit_widgets/edit_purchase_product_details_widget.dart';
import 'package:pakkahishab/features/purchase/presentation/widgets/purchase_return_widgets/return_purchase_product_details_widget.dart';

class ReturnPurchaseProductItemWidget extends StatelessWidget {
  const ReturnPurchaseProductItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        
        final vm = ref.watch(purchaseReturnViewModel);
        final vmn = ref.watch(purchaseReturnViewModel.notifier);
        final productList = vm.selectedPurchaseProducts?.length ?? [].length;
        return productList == 0? SizedBox(): Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Products",
                        style: AppTextStyle.labelLarge,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Quantity",
                        style: AppTextStyle.labelLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Unit Price",
                        style: AppTextStyle.labelLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Total",
                        style: AppTextStyle.labelLarge,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(width: 30),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: productList,
                itemBuilder: (context, index) {
                  final product = vm.selectedPurchaseProducts?[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6 ,right: 10, left: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                product!.productName.toString(),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                product.quantity.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                product.unitPrice.toStringAsFixed(1),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                (product.unitPrice * product.quantity)
                                    .toStringAsFixed(1),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                vmn.selectedPurchaseProductId = product.productId;
                                vmn.selectedPurchaseProductName = product.productName;
                                vmn.selectedPurchaseProductPrice = product.unitPrice.toString();
                                vmn.purchaseProductQuantity.text = product.quantity.toString();
                                navigateWithSlide(context: context, page: ReturnPurchaseProductDetailsAddWidget(selectedPurchaseDetailProduct: product,));
                              },
                              child: Icon(Icons.edit, size: 20)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
