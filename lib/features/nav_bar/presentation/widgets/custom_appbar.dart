import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/di/translation_provider.dart';
import 'package:pakkahishab/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';

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
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: const Icon(Icons.menu, color: AppColors.whiteColor),
      ),

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
      actions: [
        Consumer(
          builder: (context, ref, child) {
            final vm = ref.watch(homeProvider.notifier);
            return PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ), // Change radius here
              ),
              color: Colors.white,
              onSelected: (value) {
                vm.updateFilter(value);
                vm.fetchDashBoard(value);
              },
              initialValue: ref.watch(homeProvider).filter,
              icon: Icon(FontAwesomeIcons.filter, color: Colors.white),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(value: "TODAY", child: Text("Today")),
                  PopupMenuItem(value: "MONTH", child: Text("Month")),
                  PopupMenuItem(value: "YEAR", child: Text("Year")),
                ];
              },
            );
          },
        ),

        // InkWell(onTap: () {

        // }, child: Icon(FontAwesomeIcons.filter, color: Colors.white,)),
        SizedBox(width: 8),
        Padding(
          padding: EdgeInsetsGeometry.only(right: 10),
          child: Consumer(
            builder: (context, ref, child) {
              final translation = ref.watch(translationProvider);
              return InkWell(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                onTap: () {
                  if (translation.appLocale.languageCode == 'en') {
                    ref
                        .read(translationProvider.notifier)
                        .changeLanguage(const Locale('bn'));
                  } else {
                    ref
                        .read(translationProvider.notifier)
                        .changeLanguage(const Locale('en'));
                  }
                },
                child: Ink(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: AppColors.primaryColor2,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.languageType,
                    style: AppTextStyle.bodyMediumWhite,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
