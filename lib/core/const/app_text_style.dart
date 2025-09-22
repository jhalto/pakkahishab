import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// TextStyle globalTextStyle({
//   double fontSize = 14,
//   FontWeight fontWeight = FontWeight.normal,
//   double lineHeight = 1.2,
//   Color color = Colors.black,
//   TextDecoration? decoration,
//   Color? decorationColor,
//   List<Shadow>? shadows,

// }) {
//   return GoogleFonts.roboto(
//     fontSize: fontSize,
//     fontWeight: fontWeight,
//     height: lineHeight,
//     color: color,
//     decoration: decoration,
//     decorationColor: decorationColor,
//     shadows: shadows,
//   );
// }

// Headlines
class AppTextStyle {
  static final TextStyle headline1 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 32.sp,
    height: 1.2,
  );

  static final TextStyle headline2 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 28.sp,
    height: 1.2,
  );

  static final TextStyle headline3 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24.sp,
    height: 1.2,
  );

  /// Extra Large Title
  static final TextStyle titleExtraLarge = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 22.sp,
    height: 1.2,
  );

  /// Titles
  static final TextStyle titleLarge = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
    height: 1.2,
  );

  static final TextStyle titleMedium = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
    height: 1.2,
  );

  static final TextStyle titleSmall = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    height: 1.2,
  );
  static final TextStyle titleSmallWhite = TextStyle(
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColor,
    fontSize: 16.sp,
    height: 1.2,
  );

  /// Body
  static final TextStyle bodyLarge = TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    height: 1.2,
  );
   static final TextStyle bodyLargeWhite = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    height: 1.2,
  );

  static final TextStyle buttonTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    height: 1.2,
  );

  static final TextStyle bodySlideBold = TextStyle(
   
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    height: 1.2,
  );

  static final TextStyle bodyMedium = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: Colors.black87,
    height: 1.2,
  );

  static final TextStyle bodyMediumSecondary = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: Colors.black54,
    height: 1.2,
  );

  static final TextStyle bodyMediumWhite = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: Colors.white,
    height: 1.2,
  );

  static final TextStyle bodySmall = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    height: 1.2,
    color: Colors.black54,
  );

  /// Labels & Buttons
  static final TextStyle labelLarge = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    height: 1.2,
  );

  static final TextStyle labelMedium = TextStyle(
    color: Colors.black54,
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
    height: 1.2,
  );

  static final TextStyle labelSmall = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 10.sp,
    height: 1.2,
  );

  /// Captions or Footnotes
  static final TextStyle caption = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 12.sp,
    color: const Color(0xFF757575),
  );
}
