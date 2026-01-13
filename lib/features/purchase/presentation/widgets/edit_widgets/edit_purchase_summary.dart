import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_add_viewmodel.dart';

class EditPurchaseSummury extends StatelessWidget {
  const EditPurchaseSummury({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final vmn = ref.watch(purchaseAddViewModelProvider.notifier);
        final vm = ref.watch(purchaseAddViewModelProvider);

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
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          border: Border.all(color: AppColors.dotColor),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text(
                          vm.purchaseNetAmount == null
                              ? '0'
                              : vm.purchaseNetAmount.toString(),
                          style: AppTextStyle.titleSmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
