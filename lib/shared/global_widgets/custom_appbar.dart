
import 'package:flutter/material.dart';

import '../../core/const/app_colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppbar({super.key, required this.title});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      leading: InkWell(
        borderRadius:const BorderRadius.all(Radius.circular(50)),
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child:const Icon(Icons.menu, color: AppColors.whiteColor,)),
      
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor,
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
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
