import 'package:flutter/material.dart';

import '../../core/const/app_colors.dart';


class CustomContainerButton extends StatelessWidget {
  const CustomContainerButton({
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
    
    borderRadius: BorderRadius.circular(radius ?? 10),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius ?? 10),
      child: Ink(
        width: width,
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical ?? 14,
          horizontal: paddingHorizontal ?? 22,
        ),
        decoration: BoxDecoration(
          color: gradient == null ? (color ?? AppColors.primaryColor) : null,
          gradient: gradient ??
              LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [AppColors.primaryColor2, AppColors.primaryColor],
              ),
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 8),
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
            ),
          ],
        ),
      ),
    ),
  );
}
}