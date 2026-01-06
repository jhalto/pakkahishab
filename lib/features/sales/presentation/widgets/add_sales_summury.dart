import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/features/sales/presentation/viewmodels/sales_add_viewmodel.dart';

class AddSalesSummury extends StatelessWidget {
  const AddSalesSummury({super.key});
   
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final _vmn = ref.watch(saleAddViewModelProvider.notifier);

      return Container(
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Amount", style: AppTextStyle.bodyLarge),
                      Icon(FontAwesomeIcons.bangladeshiTakaSign, size: 16),
                    ],
                  ),
                ),

                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      border: Border.all(color: AppColors.dotColor),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextField(
                      
                      controller: _vmn.saleNetAmountController,
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                      
                        isDense: true,
                        border: InputBorder.none),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Total Amount", style: AppTextStyle.bodyLarge),
            //           Icon(FontAwesomeIcons.bangladeshiTakaSign, size: 16),
            //         ],
            //       ),
            //     ),

            //     SizedBox(width: 10),
            //     Expanded(
            //       child: Container(
            //         alignment: Alignment.centerRight,
            //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            //         decoration: BoxDecoration(
            //           color: AppColors.whiteColor,
            //           border: Border.all(color: AppColors.dotColor),
            //           borderRadius: BorderRadius.all(Radius.circular(10)),
            //         ),
            //         child: TextField(
            //           controller: _vmn.purchasetotalAmountController,
            //           cursorColor: AppColors.primaryColor,
            //           decoration: InputDecoration(
            //             isDense: true,
            //             border: InputBorder.none),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 10),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Paid Price", style: AppTextStyle.bodyLarge),
            //           Icon(FontAwesomeIcons.bangladeshiTakaSign, size: 16),
            //         ],
            //       ),
            //     ),

            //     SizedBox(width: 10),
            //     Expanded(
            //       child: Container(
            //         alignment: Alignment.centerRight,
            //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            //         decoration: BoxDecoration(
            //           color: AppColors.whiteColor,
            //           border: Border.all(color: AppColors.dotColor),
            //           borderRadius: BorderRadius.all(Radius.circular(10)),
            //         ),
            //         child: TextField(
            //           controller: _vmn.purchasePaidPriceController,
            //           cursorColor: AppColors.primaryColor,
            //           decoration: InputDecoration(
            //             isDense: true,
            //             border: InputBorder.none),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 10),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Due", style: AppTextStyle.bodyLarge),
            //           Icon(FontAwesomeIcons.bangladeshiTakaSign, size: 16),
            //         ],
            //       ),
            //     ),

            //     SizedBox(width: 10),
            //     Expanded(
            //       child: Container(
            //         alignment: Alignment.centerRight,
            //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            //         decoration: BoxDecoration(
            //           color: AppColors.whiteColor,
            //           border: Border.all(color: AppColors.dotColor),
            //           borderRadius: BorderRadius.all(Radius.circular(10)),
            //         ),
            //         child: TextField(
            //           controller: _vmn.purchaseDuePriceController,
            //           cursorColor: AppColors.primaryColor,
            //           decoration: InputDecoration(
            //             isDense: true,
            //             border: InputBorder.none),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    ); 
    },); 
  }
}
