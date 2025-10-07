
import 'package:flutter/material.dart';

import 'package:pakkahishab/core/const/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
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
    this.icon,
  });

  final VoidCallback onTap;
  final String title;
  final Color? color;
  final Color? fontColor;
  final double? paddingVertical;
  final double? radius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Gradient? gradient;
  final double? width;
  final double? paddingHorizontal;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      
      child: InkWell(
        borderRadius: BorderRadius.circular(radius ?? 6),
        onTap: onTap,
        child: Ink(
          width: width,
          padding: EdgeInsets.symmetric(
            vertical: paddingVertical ?? 14,
            horizontal: paddingHorizontal ?? 22,
          ),
          decoration: BoxDecoration(
            color: color,
            gradient: color == null?
                gradient ??
                const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [AppColors.primaryColor2, AppColors.primaryColor],
                ):null,
            borderRadius: BorderRadius.circular(radius ?? 6),
          ),
      
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                icon!,
               const SizedBox(width: 8), // space between icon and text
              ],
              Text(
                title,
                style: TextStyle(
                  
                  color: fontColor ?? Colors.white,
                  fontSize: fontSize ?? 16,
                  fontWeight: fontWeight ?? FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
