
import 'package:flutter/material.dart';
import 'package:pakkahishab/core/const/app_colors.dart';

class CustomBoxShadow {
  static BoxShadow get defaultShadow => BoxShadow(
        color: AppColors.blackColor.withAlpha(20),
        blurRadius: 0.00001,
        spreadRadius: 0.01,
        offset: const Offset(0, 4),
      );
}