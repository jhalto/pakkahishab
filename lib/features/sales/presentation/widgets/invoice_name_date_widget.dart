import 'package:flutter/material.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';

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
      child: Row(
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
                "29384793284",
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
                "31/12/2025",
                style: AppTextStyle.bodySmall.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 8),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                child: Icon(Icons.calendar_today, size: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
