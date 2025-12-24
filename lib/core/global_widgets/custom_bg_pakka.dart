import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/di/translation_provider.dart';

class CustomBgPakka extends StatelessWidget {
  const CustomBgPakka({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top,
              left: 16,
              right: 16,
              bottom: 10,
            ),
            alignment: .center,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 10, 117, 240),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.borderColor,
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
                Row(
                  children: [
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
                              width: 41,
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.borderColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                translation.appLocale.languageCode == 'en'
                                    ? "Bn"
                                    : "En",
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
                child: Column(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
