import 'package:flutter/material.dart';

import '../../core/const/app_colors.dart';
import '../../core/const/app_text_style.dart';



class CustomField extends StatelessWidget {
  final String? hint;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final bool isLoading; // new parameter

  const CustomField({
    super.key,
    this.hint,
    this.prefixIcon,
    required this.controller,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      cursorColor: AppColors.primaryTextColor,
      style: TextStyle(
        fontSize: 14,
        color: isLoading ? Colors.transparent : AppColors.primaryTextColor,
      ),
      controller: controller,
      // enabled: !isLoading,
      readOnly: isLoading,
      decoration: InputDecoration(
       border: InputBorder.none,
       
        prefixIconConstraints: BoxConstraints(minWidth: 50),
        prefixIcon: prefixIcon,
        hintText: hint,
        hintStyle:AppTextStyle. bodyMediumSecondary,
        filled: true,
        fillColor: AppColors.fillColor,
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 19),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xffF4F4F4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xffF4F4F4)),
        ),
      ),
    );
  }
}