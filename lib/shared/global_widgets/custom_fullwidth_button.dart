import 'package:flutter/material.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';

class CustomFullwidthButton extends StatelessWidget {
  const CustomFullwidthButton({
    super.key,
    required this.onTap,
    required this.title,
    this.isLoading = false,
    this.color,
    this.paddingVertical,
    this.radius,
    this.fontSize,
    this.fontWeight,
    this.gradient,
    this.width,
    this.fontColor,
    this.paddingHorizontal,
    this.border,
    this.style,
  });

  final Future<void> Function()? onTap;
  final String title;
  final bool isLoading; // 👈 new
  final Color? color;
  final Color? fontColor;
  final double? paddingVertical;
  final double? radius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Gradient? gradient;
  final double? width;
  final double? paddingHorizontal;
  final Border? border;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius ?? 10),
      onTap: isLoading ? null : onTap, // disable when loading
      child: Ink(
        width: width ?? double.infinity,
        padding: EdgeInsets.symmetric(vertical: paddingVertical ?? 16),
        decoration: BoxDecoration(
          border:border,
          color: color,
          gradient: color == null
              ? gradient ??
                    LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [AppColors.primaryColor2, AppColors.primaryColor],
                    )
              : null,
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: 23,
                  width: 23,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  title,
                  style:style?? AppTextStyle.buttonTextStyle,
                  textAlign: TextAlign.center,
                  
                ),
        ),
      ),
    );
  }
}
