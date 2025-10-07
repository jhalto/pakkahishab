import 'package:flutter/material.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/features/home/presentation/views/home_view.dart';
import 'package:pakkahishab/features/home/presentation/widgets/app_drawer.dart';
import 'package:pakkahishab/features/nav_bar/presentation/widgets/bottom_bar_design.dart';
import 'package:pakkahishab/features/nav_bar/presentation/widgets/custom_appbar.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';


class NavbarView extends StatelessWidget {
  const NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: AppLocalizations.of(context)!.appName),
      drawer: const AppDrawer(),
      body: const HomeView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(50)),
        ),
        onPressed: () {
          // handle dock button press
        },
        backgroundColor: AppColors.primaryColor,
        elevation: 4,
        child: const Icon(Icons.add, color: AppColors.whiteColor),
      ),
      bottomNavigationBar: const BottomBarDesign()
    );
  }
}
