import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/utils/loader.dart';
import 'package:pakkahishab/features/purchase/presentation/viewmodels/purchase_viewmodel.dart';
import 'package:pakkahishab/shared/global_widgets/custom_appbar_back.dart';

class PurchasesView extends StatelessWidget {
  const PurchasesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBack(title: "Purchases"),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            color: Colors.white,
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text("Total Item", style: AppTextStyle.labelLarge),
                        SizedBox(height: 2),
                        Text("2", style: AppTextStyle.labelLarge),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: VerticalDivider(),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text("Total Price", style: AppTextStyle.labelLarge),
                        SizedBox(height: 2),
                        Text("2", style: AppTextStyle.labelLarge),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Consumer(
            builder: (context, ref, child) {
              final purchaseState = ref.watch(purchaseViewModelProvider);
              if (purchaseState.loading) {
                return Expanded(child: loader);
              }
              if (purchaseState.purchaseList.isEmpty) {
                return Expanded(child: const Center(child: Text("No purchases")));
              }
              return Expanded(
                child:
                    ListView.builder(
                      itemCount: purchaseState.purchaseList.length,
                      itemBuilder: (context, index) {
                        final item = purchaseState.purchaseList[index];
                        final formattedDate = DateFormat(
                          'dd MMM',
                        ).format(item.purchaseDate);
                        final formattedTime = DateFormat(
                          'hh:mma ',
                        ).format(item.purchaseDate);
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 2,
                            left: 10,
                            right: 10,
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.blackColor.withAlpha(20),
                                  blurRadius: .00001,
                                  spreadRadius: .01,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Column(
                                      children: [
                                        Text(
                                          formattedDate,
                                          style: AppTextStyle.bodyMedium
                                              .copyWith(
                                                color: AppColors.primaryColor2,
                                                fontSize: 16.sp,
                                              ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          formattedTime,
                                          style: AppTextStyle.bodySmall
                                              .copyWith(
                                                color: AppColors.primaryColor2,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(color: AppColors.fillColor2),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.supplierName.toString(),
                                              style: AppTextStyle.bodyMedium,
                                            ),
                                            Text(
                                              item.mobile,
                                              style: AppTextStyle.bodySmall,
                                            ),

                                            SizedBox(height: 10),
                                            Text(
                                              "${item.netAmount.toString()} Tk",
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (item.due == 0)
                                              Text(
                                                "Paid",
                                                style: AppTextStyle.bodyMedium
                                                    .copyWith(
                                                      color: Color(0xff50AA53),
                                                    ),
                                              ),

                                            if (item.due == item.netAmount)
                                              Text(
                                                "Unpaid",
                                                style: AppTextStyle.bodyMedium
                                                    .copyWith(
                                                      color: Color(0xfff5a848),
                                                    ),
                                              ),
                                            if (item.due != 0)
                                              Text(
                                                "Partial",
                                                style: AppTextStyle.bodyMedium
                                                    .copyWith(
                                                      color: AppColors
                                                          .primaryColor2,
                                                    ),
                                              ),
                                            if (item.due != 0)
                                              Text(
                                                item.due.toString(),
                                                style: AppTextStyle.bodyMedium
                                                    .copyWith(
                                                      color: AppColors
                                                          .primaryColor2,
                                                    ),
                                              ),

                                            // if (item.due == item.netAmount)
                                            //   Text(
                                            //     item.netAmount.toString(),
                                            //     style:
                                            //         AppTextStyle.bodyMedium,
                                            //   ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: PopupMenuButton(
                                      menuPadding: EdgeInsets.zero,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      icon: Icon(
                                        CupertinoIcons.chevron_down,
                                        size: 20,
                                      ),
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                ShaderMask(
                                                  shaderCallback: (bounds) =>
                                                      const LinearGradient(
                                                        colors: [
                                                          Color(0xFF4FACFE),
                                                          Color(0xFF00F2FE),
                                                        ],
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ).createShader(bounds),
                                                  child: const Icon(
                                                    Icons.print,
                                                    size: 30,
                                                    color: Colors
                                                        .white, // Important: Keep white to reveal gradient
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Text("Print Invoice"),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(
                                            onTap: () {},
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.local_print_shop_sharp,
                                                  color:
                                                      AppColors.accentTextColor,
                                                ),
                                                SizedBox(width: 10),
                                                Text("Print Invoice"),
                                              ],
                                            ),
                                          ),
                                        ];
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    
                  
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
