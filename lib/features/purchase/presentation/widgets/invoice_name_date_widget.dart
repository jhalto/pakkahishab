import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/helper/date_picker_helper.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_add_viewmodel.dart';

class InvoiceNameDateWidget extends StatelessWidget {
  const InvoiceNameDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),

      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Consumer(
        builder: (context, ref, child) {
          final _vmn = ref.read(purchaseAddViewModelProvider.notifier);
          final _vm = ref.watch(purchaseAddViewModelProvider);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Invoice No:",
                    style: AppTextStyle.bodySmall.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 2),
                  Text(
                    ref
                        .read(purchaseAddViewModelProvider.notifier)
                        .generateInvoiceNumber(),
                    style: AppTextStyle.bodySmall.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Invoice Date:",
                    style: AppTextStyle.bodySmall.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 2),
                  Text(
                    ref
                        .watch(purchaseAddViewModelProvider)
                        .purchaseDate
                        .toString(),
                    style: AppTextStyle.bodySmall.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () async {
                      final pickedDate = await pickDate(context: context);

                      print(pickedDate);

                      _vmn.updatePurchaseDate(date: pickedDate.toString());
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Icon(Icons.calendar_today, size: 16),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
