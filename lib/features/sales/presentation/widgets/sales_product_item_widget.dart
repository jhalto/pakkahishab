import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/features/sales/presentation/viewmodels/sales_add_viewmodel.dart';

class SalesProductItemWidget extends StatelessWidget {
  const SalesProductItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final vm = ref.watch(saleAddViewModelProvider);
        final vmn = ref.watch(saleAddViewModelProvider.notifier);
        final productList = vm.selectedSaleProducts?.length ?? [].length;
        return productList == 0
            ? SizedBox()
            : Column(
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
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: productList,
                      itemBuilder: (context, index) {
                        final product = vm.selectedSaleProducts?[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 6,
                            right: 10,
                            left: 10,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      vmn.selectedSaleProductId =
                                          product.productId;
                                      vmn.selectedSaleProductName =
                                          product.productName;
                                      vmn.selectedSaleProductPrice = product
                                          .unitPrice
                                          .toString();
                                      vmn.saleProductQuantity.text = product
                                          .quantity
                                          .toString();
                                      // navigateWithSlide(context: context, page: SaleProductDetailsAddWidget(selectedPurchaseDetailProduct: product,));
                                    },
                                    child: Icon(Icons.edit, size: 20),
                                  ),
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
