import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/const/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      customBorder: const CircleBorder(), // Match the shape
      splashColor: AppColors.blackColor.withAlpha(2),
      
      child: Padding(
        padding: const EdgeInsets.all(6.0), // Increase tap area
        child: Icon(
          CupertinoIcons.back,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
