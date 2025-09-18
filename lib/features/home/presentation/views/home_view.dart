import 'package:flutter/material.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/features/home/presentation/widgets/app_drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(),
      drawerScrimColor: AppColors.accentTextColor,
      drawer: AppDrawer(),
    );
  }
}