import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/features/home/data/services/home_services.dart';
import 'package:pakkahishab/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:pakkahishab/features/home/presentation/widgets/custom_feature_widget.dart';
import 'package:pakkahishab/l10n/app_localization_extension.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';
import 'package:pakkahishab/shared/global_widgets/custom_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
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
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
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
                      SizedBox(
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
                            SizedBox(height: 2),
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
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.totalPurchase,
                            style: AppTextStyle.bodyMedium.copyWith(
                              color: AppColors.primaryColor4,
                            ),
                          ),
                          SizedBox(height: 2),
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
                    SizedBox(
                      height: 30,
                      child: VerticalDivider(color: AppColors.primaryColor2),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.totalSales,
                            style: AppTextStyle.bodyMedium.copyWith(
                              color: AppColors.primaryColor4,
                            ),
                          ),
                          SizedBox(height: 2),
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
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(color: AppColors.primaryColor2),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.totalPayable,
                              style: AppTextStyle.bodyMedium.copyWith(
                                color: AppColors.primaryColor4,
                              ),
                            ),
                            const SizedBox(height: 2),
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
                      SizedBox(
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
                            SizedBox(height: 2),
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
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  CustomFeatureWidget(
                    title: Text(AppLocalizations.of(context)!.expenses),
                    consumer: Consumer(
                      builder: (context, ref, child) =>
                          Text(ref.watch(homeProvider).expenses),
                    ),
                  ),
                  SizedBox(width: 10),
                  CustomFeatureWidget(
                    title: Text(AppLocalizations.of(context)!.income),
                    consumer: Consumer(
                      builder: (context, ref, child) =>
                          Text(ref.watch(homeProvider).income),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  CustomFeatureWidget(
                    title: Text(AppLocalizations.of(context)!.stock),
                    consumer: Consumer(
                      builder: (context, ref, child) =>
                          Text(ref.watch(homeProvider).stock),
                    ),
                  ),
                  SizedBox(width: 10),
                  CustomFeatureWidget(
                    title: Text(AppLocalizations.of(context)!.advance),
                    consumer: Consumer(
                      builder: (context, ref, child) =>
                          Text(ref.watch(homeProvider).advance),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  CustomFeatureWidget(
                    title: Text(AppLocalizations.of(context)!.loan),
                    consumer: Consumer(
                      builder: (context, ref, child) =>
                          Text(ref.watch(homeProvider).loan),
                    ),
                  ),
                  SizedBox(width: 10),
                  CustomFeatureWidget(
                    title: Text(AppLocalizations.of(context)!.mobileBanking),
                    consumer: Consumer(
                      builder: (context, ref, child) =>
                          Text(ref.watch(homeProvider).mobileBanking),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Expanded(
        //   child: Padding(
        //     padding: const EdgeInsets.all(12.0),
        //     child: Consumer(
        //       builder: (context, ref, child) {
        //         final vm = ref.watch(homeProvider); // use watch instead of read

        //         return GridView.builder(
        //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //             crossAxisCount: 2,
        //             childAspectRatio: 2.5,
        //             crossAxisSpacing: 10,
        //           ),

        //           itemCount: vm.items.length,
        //           itemBuilder: (context, index) {
        //             return Padding(
        //               padding: const EdgeInsets.only(bottom: 10),
        //               child: InkWell(
        //                 onTap: () {},
        //                 child: Ink(
        //                   padding: const EdgeInsets.all(10),
        //                   decoration: BoxDecoration(
        //                     border: Border.all(
        //                       color: AppColors.primaryColor4.withAlpha(50),
        //                       width: 3,
        //                       strokeAlign: .3,
        //                     ),
        //                     borderRadius: BorderRadius.circular(8),
        //                   ),
        //                   child: Row(
        //                     children: [
        //                       Container(
        //                         padding: EdgeInsets.all(8),
        //                         decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(8),
        //                           color: AppColors.primaryColor2,
        //                         ),

        //                         child: Icon(
        //                           vm.icons[index],
        //                           color: AppColors.whiteColor,
        //                         ),
        //                       ),
        //                       SizedBox(width: 20),
        //                       Expanded(
        //                         child: Column(
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           children: [
        //                             Text(
        //                               AppLocalizations.of(
        //                                 context,
        //                               )!.translate(vm.items[index]),
        //                             ),
        //                             Text("50"),
        //                           ],
        //                         ),
        //                       ),
        //                       Icon(
        //                         CupertinoIcons.forward,
        //                         color: AppColors.primaryColor2,
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             );
        //           },
        //         );
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
