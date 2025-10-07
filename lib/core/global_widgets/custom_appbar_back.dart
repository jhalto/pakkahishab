
import 'package:flutter/material.dart';
import 'package:pakkahishab/core/global_widgets/custom_back_button.dart';

import 'package:pakkahishab/core/const/app_colors.dart';

class CustomAppbarBack extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppbarBack({super.key, required this.title});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: CustomBackButton(),
      centerTitle: false,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor,
        ),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryColor2, AppColors.primaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
