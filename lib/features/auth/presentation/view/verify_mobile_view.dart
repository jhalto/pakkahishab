import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/const/images_path.dart';
import 'package:pakkahishab/core/helper/validation_helper.dart';
import 'package:pakkahishab/features/auth/presentation/viewmodel/signup_viewmodel.dart';
import 'package:pakkahishab/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';
import 'package:pakkahishab/shared/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/shared/global_widgets/custom_form_field.dart';
import 'package:pakkahishab/shared/global_widgets/custom_fullwidth_button.dart';

class VerifyMobileView extends StatelessWidget {
  const VerifyMobileView({super.key});

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
                  Image.asset(ImagesPath.logo, width: screenWidth * .52),
                  SizedBox(height: 60.h),
                  // Text("Change Number", style: AppTextStyle.titleMedium),
                  const SizedBox(height: 10),

                  SizedBox(height: 20.h),
                  Text(
                    AppLocalizations.of(context)!.enterYourNumberBelow,
                    style: AppTextStyle.bodyLarge,
                  ),

                  const SizedBox(height: 15),
                  Consumer(
                    builder: (context, ref, child) {
                      print("Phone build");
                      final phoneError = ref.watch(
                        signupNotifierProvider.select((vm) => vm.phoneError),
                      );

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            onDone: () {
                              ref
                                  .read(signupNotifierProvider.notifier)
                                  .verifyNumber2(context);
                            },
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: AppColors.primaryColor,
                            ),
                            hint: AppLocalizations.of(context)!.phone,
                            onChanged: (value) => ref
                                .read(signupNotifierProvider.notifier)
                                .updatePhone2(value, context),
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 2),
                          if (phoneError.isNotEmpty)
                            Text(
                              phoneError,
                              style: const TextStyle(
                                color: AppColors.errorTextColor,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                  Consumer(
                    builder: (context, ref, child) {
                      final vm = ref.watch(signupNotifierProvider);
                      return CustomFullwidthButton(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          ref
                              .read(signupNotifierProvider.notifier)
                              .verifyNumber2(context);
                        },
                        isLoading: vm.isLoading,
                        title: AppLocalizations.of(context)!.confirm,
                        fontColor: AppColors.whiteColor,
                      );
                    },
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
