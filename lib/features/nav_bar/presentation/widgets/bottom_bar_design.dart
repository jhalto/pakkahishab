import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/features/purchase/presentation/views/purchases_view.dart';
import 'package:pakkahishab/features/sales/presentation/views/sale_view.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';

class BottomBarDesign extends StatelessWidget {
  const BottomBarDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomAppBar(
          clipBehavior: Clip.antiAlias,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          elevation: 10,
          color: AppColors.borderColor,
          child: SizedBox(
            child: Row(
              children: [
                // Left side icons
                Expanded(
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PurchasesView()),
                      );
                    },
                    child: Ink(
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor3,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.moneyCheck,
                            color: AppColors.whiteColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            AppLocalizations.of(context)!.purchase,
                            style: const TextStyle(color: AppColors.whiteColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Spacer for FAB
                const Expanded(child: SizedBox()),

                // Right side icons
                Expanded(
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SaleView()),
                      );
                    },
                    child: Ink(
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor2,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.bangladeshiTakaSign,
                            color: AppColors.whiteColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            AppLocalizations.of(context)!.sales,
                            style: const TextStyle(color: AppColors.whiteColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}