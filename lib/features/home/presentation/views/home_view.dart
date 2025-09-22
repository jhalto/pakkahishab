import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/features/home/presentation/viewmodels/home_viewmodel.dart';

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
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Cash in Hand",
                            style: AppTextStyle.bodyMediumWhite,
                          ),
                          Text("6366", style: AppTextStyle.titleSmallWhite),
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
                            "Cash at Bank",
                            style: AppTextStyle.bodyMediumWhite,
                          ),
                          Text("6366", style: AppTextStyle.titleSmallWhite),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.white),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Total Purchase",
                            style: AppTextStyle.bodyMediumWhite,
                          ),
                          Text("6366", style: AppTextStyle.titleSmallWhite),
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
                            "Total Sales",
                            style: AppTextStyle.bodyMediumWhite,
                          ),
                          Text("6366", style: AppTextStyle.titleSmallWhite),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.white),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Total Payable",
                            style: AppTextStyle.bodyMediumWhite,
                          ),
                          Text("6366", style: AppTextStyle.titleSmallWhite),
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
                            "Total Receivable",
                            style: AppTextStyle.bodyMediumWhite,
                          ),
                          Text("6366", style: AppTextStyle.titleSmallWhite),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Consumer(
              builder: (context, ref, child) {
                final vm = ref.watch(
                  homeViewModelProvider,
                ); // use watch instead of read
                return ListView.builder(
                  itemCount: vm.items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${vm.items[index]} clicked"),
                            ),
                          );
                        },
                        child: Ink(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.borderColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.primaryColor2,
                                ),

                                child: Icon(
                                  vm.icons[index],
                                  color: AppColors.whiteColor,
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text(vm.items[index], ),Text("50")],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
