import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';
import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/core/global_widgets/custom_fullwidth_button.dart';

class NumberVerificationView extends StatelessWidget {
  const NumberVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: CustomAppbarBack(
          title: AppLocalizations.of(context)!.changeNumber,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Image.asset(
                  //   ImagesPath.log,
                  //   height: screenHeight * .12,
                  //   width: screenWidth * .7,
                  // ),
                  SizedBox(height: 60.h),
                  // Text("Change Number", style: AppTextStyle.titleMedium),
                  const SizedBox(height: 10),

                  SizedBox(height: 20.h),
                  Text(
                    AppLocalizations.of(context)!.enterYourNumberBelow,
                    style: AppTextStyle.bodyLarge,
                  ),

                  const SizedBox(height: 15),
                  CustomTextField(
                    hint: AppLocalizations.of(context)!.enterPhoneNumber,
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: AppColors.primaryColor,
                    ),

                    textInputAction: TextInputAction.done,
                    onDone: () {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 50),
                  CustomFullwidthButton(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                    },
                    title: AppLocalizations.of(context)!.confirm,
                    fontColor: AppColors.whiteColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
