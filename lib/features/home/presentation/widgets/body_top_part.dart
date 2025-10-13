import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';
import 'package:pakkahishab/routes/app_routes.dart';

class BodyTopPart extends StatelessWidget {
  const BodyTopPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryColor2,
            width: 2,
            strokeAlign: .7,
          ),
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),

        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor2,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.cashInHand,
                          style: AppTextStyle.bodyMediumWhite,
                        ),
                        const SizedBox(height: 2),
                        Consumer(
                          builder: (context, ref, child) {
                            return Text(
                              ref.watch(homeProvider).cashInHand,
                              style: AppTextStyle.titleMedium.copyWith(
                                color: AppColors.whiteColor,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                    child: VerticalDivider(color: AppColors.whiteColor),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.cashAtBank,
                          style: AppTextStyle.bodyMediumWhite,
                        ),
                        const SizedBox(height: 2),
                        Consumer(
                          builder: (context, ref, child) {
                            return Text(
                              ref.watch(homeProvider).cashAtBank,
                              style: AppTextStyle.titleMedium.copyWith(
                                color: AppColors.whiteColor,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.purchase);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.totalPurchase,
                              style: AppTextStyle.bodyMedium.copyWith(
                                color: AppColors.primaryColor4,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Consumer(
                              builder: (context, ref, child) {
                                return Text(
                                  ref.watch(homeProvider).totalPurchase,
                                  style: AppTextStyle.titleMedium.copyWith(
                                    color: AppColors.primaryColor4,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                  child: VerticalDivider(color: AppColors.primaryColor2),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.sales);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.totalSales,
                              style: AppTextStyle.bodyMedium.copyWith(
                                color: AppColors.primaryColor4,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Consumer(
                              builder: (context, ref, child) {
                                return Text(
                                  ref.watch(homeProvider).totalSales,
                                  style: AppTextStyle.titleMedium.copyWith(
                                    color: AppColors.primaryColor4,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(color: AppColors.primaryColor2),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        onTap: () {
                          Navigator.pushNamed(context, Routes.supplierDues);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.totalPayable,
                                style: AppTextStyle.bodyMedium.copyWith(
                                  color: AppColors.primaryColor4,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Consumer(
                                builder: (context, ref, child) {
                                  return Text(
                                    ref.watch(homeProvider).totalPayable,
                                    style: AppTextStyle.titleMedium.copyWith(
                                      color: AppColors.primaryColor4,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                    child: VerticalDivider(color: AppColors.primaryColor2),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.totalReceivable,
                          style: AppTextStyle.bodyMedium.copyWith(
                            color: AppColors.primaryColor4,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Consumer(
                          builder: (context, ref, child) {
                            return Text(
                              ref.watch(homeProvider).totalReceivable,
                              style: AppTextStyle.titleMedium.copyWith(
                                color: AppColors.primaryColor4,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
