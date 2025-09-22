import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/features/auth/presentation/view/signup_view.dart';
import 'package:pakkahishab/features/home/presentation/views/home_view.dart';
import 'package:pakkahishab/features/home/presentation/widgets/app_drawer.dart';
import 'package:pakkahishab/features/nav_bar/presentation/viewmodel/navbar_viewmodel.dart';
import 'package:pakkahishab/features/nav_bar/presentation/widgets/bottom_bar_design.dart';
import 'package:pakkahishab/features/purchase/presentation/views/purchase_view.dart';
import 'package:pakkahishab/features/sales/presentation/views/sale_view.dart';
import 'package:pakkahishab/routes/app_routes.dart';
import 'package:pakkahishab/shared/global_widgets/custom_appbar.dart';

class NavbarView extends StatelessWidget {
  const NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "PakkaHishab"),
      drawer: const AppDrawer(),
      body: HomeView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(50)),
        ),
        onPressed: () {
          // handle dock button press
        },
        backgroundColor: AppColors.primaryColor,
        elevation: 4,
        child: const Icon(Icons.add, color: AppColors.whiteColor),
      ),
      bottomNavigationBar: BottomBarDesign()
    );
  }
}
