import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/di/translation_provider.dart';
import 'package:pakkahishab/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:pakkahishab/features/home/presentation/widgets/app_drawer.dart';
import 'package:pakkahishab/features/home/presentation/widgets/body_middle_part.dart';
import 'package:pakkahishab/features/home/presentation/widgets/body_top_part.dart';
import 'package:pakkahishab/features/home/presentation/widgets/bottom_bar_design.dart';
import 'package:unicons/unicons.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top,
              left: 5,
              right: 16,
              bottom: 10,
            ),
            alignment: .center,
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Builder(
                      builder: (context) {
                        return IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: Icon(Icons.menu, color: AppColors.whiteColor),
                        );
                      },
                    ),
                    SizedBox(width: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisSize: .min,

                        children: [
                          Text("Basic"),
                          SizedBox(width: 10),
                          Icon(CupertinoIcons.chevron_down, size: 20),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        final vm = ref.watch(homeProvider.notifier);
                        final option = ['All', 'Today', 'Month', 'Year'];
                        return PopupMenuButton(
                          requestFocus: false,

                          shape: const RoundedRectangleBorder(
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
                          icon: const Icon(
                            UniconsLine.filter,
                            color: Colors.white,
                            size: 26,
                          ),
                          itemBuilder: (context) {
                            return option.map((option) {
                              return PopupMenuItem(
                                value: option.toUpperCase(),
                                child: Text(option,style: AppTextStyle.bodyMedium,),
                              );
                            }).toList();
                          },
                        );
                      },
                    ),
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        onTap: () {},
                        child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.all(5),
                          child: Badge(
                            label: Text("8"),

                            child: Icon(
                              Icons.notifications_outlined,
                              size: 30,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        onTap: () {},
                        child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.help_center_outlined,
                            size: 30,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 5),
                    Consumer(
                      builder: (context, ref, child) {
                        final translation = ref.watch(translationProvider);
                        return Material(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            onTap: () {
                              // toggle between English and Bangla
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
                            child: Container(
                              alignment: .center,
                              width: 50,
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                translation.appLocale.languageCode == 'en'
                                    ? "বাং"
                                    : "EN", style: AppTextStyle.bodyMedium,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Ink(
              width: double.infinity,
              color: AppColors.primaryColor,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    BodyTopPart(),
                    SizedBox(height: 8),
                    BodyMiddlePart(),

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
                ),
              ),
            ),
          ),
        ],
      ),
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
      bottomNavigationBar: const BottomBarDesign(),
    );
  }
}
