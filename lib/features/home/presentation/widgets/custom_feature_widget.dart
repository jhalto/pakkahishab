import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pakkahishab/core/const/app_colors.dart';

class CustomFeatureWidget extends StatelessWidget {
  Widget title;
  Widget consumer;

  CustomFeatureWidget({super.key, required this.title, required this.consumer});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Ink(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primaryColor4.withAlpha(50),
              width: 3,
              strokeAlign: .3,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: AppColors.primaryColor2,
                  ),

                  child: const Icon(
                    FontAwesomeIcons.bangladeshiTakaSign,
                    color: AppColors.whiteColor,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title,
                      consumer,
                      // Text(AppLocalizations.of(context)!.expenses),
                      // Consumer(
                      //   builder: (context, ref, child) =>
                      //       Text(ref.watch(homeProvider).expenses),
                      // ),
                    ],
                  ),
                ),
                const Icon(CupertinoIcons.forward, color: AppColors.primaryColor2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
