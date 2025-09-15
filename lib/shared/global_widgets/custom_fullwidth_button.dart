
import 'package:flutter/material.dart';

import '../../core/const/app_colors.dart';


class CustomFullwidthButton extends StatelessWidget {
  const CustomFullwidthButton({
    super.key,
    required this.onTap,
    required this.title,
    this.color,
    this.paddingVertical,
    this.radius,
    this.fontSize,
    this.fontWeight,
    this.gradient,
    this.width,
    this.fontColor,
    this.paddingHorizontal,
  });

  final  Future<void> Function()? onTap;
  final Widget title;
  final Color? color;
  final Color? fontColor;
  final double? paddingVertical;
  final double? radius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Gradient? gradient;
  final double? width;
  final double? paddingHorizontal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius ?? 10),
      onTap: onTap,
      child: Ink(
        width: width ?? double.infinity,
        padding: EdgeInsets.symmetric(vertical: paddingVertical ?? 16),
        decoration: BoxDecoration(
          color: gradient == null ? (color ?? AppColors.primaryColor) : null,
          gradient: gradient??LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.primaryColor2,
                          AppColors.primaryColor,
                        ],
                      ),
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),

        child: Center(
          child: title
        ),
      ),
    );
  }
}
