import 'package:flutter/material.dart';
import 'package:pakkahishab/core/const/app_colors.dart';

double getResponsiveFontSize(BuildContext context, double baseFontSize) {
  double screenWidth = MediaQuery.of(context).size.width;
  // Example: scale font size based on 375px width (iPhone 11/12 baseline)
  return baseFontSize * (screenWidth / 375);
}

TextStyle headline1(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: getResponsiveFontSize(context, 32),
  height: 1.2,
);

TextStyle headline2(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: getResponsiveFontSize(context, 28),
  height: 1.2,
);

TextStyle headline3(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: getResponsiveFontSize(context, 24),
  height: 1.2,
);

// Extra large title
TextStyle titleExtraLarge(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: getResponsiveFontSize(context, 22),
  height: 1.2,
);
TextStyle titleExtraLargeWhite(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: getResponsiveFontSize(context, 22),
  height: 1.2,
);

// Titles
TextStyle titleLarge(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w600,
  color: AppColors.whiteColor,
  fontSize: getResponsiveFontSize(context, 20),
  height: 1.2,
);
TextStyle titleLargeWhite(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w600,
  color: AppColors.whiteColor,
  fontSize: getResponsiveFontSize(context, 20),
  height: 1.2,
);

TextStyle titleMedium(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: getResponsiveFontSize(context, 18),
  height: 1.2,
);

TextStyle titleSmall(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: getResponsiveFontSize(context, 16),
  height: 1.2,
);

// Body
TextStyle bodyLarge(BuildContext context) => TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.w400,
  fontSize: getResponsiveFontSize(context, 16),
  height: 1.2,
);

TextStyle bodySlideBold(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: getResponsiveFontSize(context, 14),
  height: 1.2,
);

TextStyle bodyMedium(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: getResponsiveFontSize(context, 14),
  color: Colors.black87,
  height: 1.2,
);

TextStyle bodyMediumWhite(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: getResponsiveFontSize(context, 14),
  color: AppColors.whiteColor,
  height: 1.2,
);

TextStyle bodyMediumSecondary(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: getResponsiveFontSize(context, 14),
  color: Colors.black54,
  height: 1.2,
);

TextStyle buttonTextStyle(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: getResponsiveFontSize(context, 16),
  color: Colors.white,
);

TextStyle bodySmall(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: getResponsiveFontSize(context, 12),
  color: Colors.black54,
  height: 1.2,
);

// Labels & Buttons
TextStyle labelLarge(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: getResponsiveFontSize(context, 14),
  height: 1.2,
);

TextStyle labelMedium(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: getResponsiveFontSize(context, 12),
  color: Colors.black54,
  height: 1.2,
);

TextStyle labelSmall(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: getResponsiveFontSize(context, 10),
  height: 1.2,
);

// Captions / Footnotes
TextStyle caption(BuildContext context) => TextStyle(
  fontWeight: FontWeight.w300,
  fontSize: getResponsiveFontSize(context, 12),
  color: const Color(0xFF757575),
);
