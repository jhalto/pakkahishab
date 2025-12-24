import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakkahishab/core/const/app_colors.dart';

class AppTextStyle {
  /// Headlines
  static TextStyle get headline1 => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 32.sp,
        height: 1.2,
      );

  static TextStyle get headline2 => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 28.sp,
        height: 1.2,
      );

  static TextStyle get headline3 => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24.sp,
        height: 1.2,
      );

  /// Extra Large Title
  static TextStyle get titleExtraLarge => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 22.sp,
        height: 1.2,
      );

  /// Titles
  static TextStyle get titleLarge => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20.sp,
        height: 1.2,
      );

  static TextStyle get titleMedium => TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w600,
        fontSize: 18.sp,
        height: 1.2,
      );

  static TextStyle get titleSmall => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
        height: 1.2,
      );

  static TextStyle get titleSmallWhite => TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.whiteColor,
        fontSize: 16.sp,
        height: 1.2,
      );

  /// Body
  static TextStyle get bodyLarge => TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        height: 1.2,
      );

  static TextStyle get bodyLargeWhite => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        height: 1.2,
      );

  static TextStyle get buttonTextStyle => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        height: 1.2,
      );

  static TextStyle get bodySlideBold => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        height: 1.2,
      );

  static TextStyle get bodyMedium => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
        color: Colors.black87,
        height: 1.2,
      );

  static TextStyle get bodyMediumSecondary => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
        color: Colors.black54,
        height: 1.2,
      );

  static TextStyle get bodyMediumWhite => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
        color: Colors.white,
        height: 1.2,
      );

  static TextStyle get bodySmall => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
        color: Colors.black87,
        height: 1.2,
      );

  /// Labels & Buttons
  static TextStyle get labelLarge => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        height: 1.2,
      );

  static TextStyle get labelMedium => TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
        height: 1.2,
      );

  static TextStyle get labelSmall => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 10.sp,
        height: 1.2,
      );

  /// Captions or Footnotes
  static TextStyle get caption => TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12.sp,
        color: const Color(0xFF757575),
      );
}