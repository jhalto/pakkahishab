import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/const/images_path.dart';
import 'package:pakkahishab/core/utils/loader.dart';
import 'package:pakkahishab/features/auth/presentation/view/change_number_view.dart';
import 'package:pakkahishab/features/auth/presentation/viewmodel/signup_viewmodel.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';
import 'package:pakkahishab/shared/global_widgets/custom_appbar_back.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Consumer(
      builder: (context, ref, child) {
        return ModalProgressHUD(
          inAsyncCall: ref.watch(signupNotifierProvider).isLoading,
          progressIndicator: loader,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: AppColors.bgColor,
              appBar: CustomAppbarBack(
                title: AppLocalizations.of(context)!.confirmOtp,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Image.asset(ImagesPath.logo, width: screenWidth * .52),
                      SizedBox(height: 60.h),
                      Text(
                        AppLocalizations.of(context)!.otp_sent,
                        style: AppTextStyle.titleMedium,
                      ),
                      const SizedBox(height: 10),

                      Consumer(
                        builder: (context, ref, child) {
                          return RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "${AppLocalizations.of(context)!.otpSentMessage} ${ref.watch(signupNotifierProvider).phone} ",
                                  style: AppTextStyle.bodyMediumSecondary,
                                ),
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ChangeNumberView(),
                                        ),
                                      );
                                    },
                                    child: const Icon(Icons.edit),
                                  ),
                                ),
                              ],
                            ),

                            textAlign: TextAlign.center,
                          );
                        },
                      ),

                      SizedBox(height: 20.h),
                      Text(
                        AppLocalizations.of(context)!.enterOtpBelow,
                        style: AppTextStyle.bodyLarge,
                      ),

                      const SizedBox(height: 15),
                      Consumer(
                        builder: (context, ref, child) {
                          return OtpTextField(
                            numberOfFields: 4,
                            focusedBorderColor: AppColors.primaryColor,
                            borderColor: AppColors.borderColor,
                            enabledBorderColor: AppColors.borderColor,
                            fillColor: AppColors.fillColor,
                            filled: true,
                            textStyle: const TextStyle(
                              height: 1.2,
                              fontSize: 24,
                              color: AppColors.primaryTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            onSubmit: (otp) {
                              ref
                                  .read(signupNotifierProvider.notifier)
                                  .confirmOtp(context, otp: otp.toString());
                            },
                            fieldWidth: 60,
                            fieldHeight: 60,
                            borderWidth: 2,

                            showFieldAsBox: true,
                          );
                        },
                      ),

                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.didntReceiveCode,
                                style: AppTextStyle.bodyMediumSecondary,
                              ),
                              Consumer(
                                builder: (context, ref, child) {
                                  final vm = ref.watch(signupNotifierProvider);
                                  return Visibility(
                                    visible: vm.isResendAvailable,
                                    child: InkWell(
                                      onTap: () {
                                        ref
                                            .read(
                                              signupNotifierProvider.notifier,
                                            )
                                            .resendOtp(context);
                                      },
                                      splashColor: Colors.black.withValues(
                                        alpha: .1,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0,
                                          vertical: 2,
                                        ),
                                        child: Text(
                                          " ${AppLocalizations.of(context)!.sendAgain}",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            height: 1.2,
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(width: 10.h),
                          Consumer(
                            builder: (context, ref, child) {
                              final vm = ref.watch(signupNotifierProvider);
                              return Visibility(
                                visible: !vm.isResendAvailable,
                                child: Text(
                                  vm.secondsRemaining.toString(),
                                  style: const TextStyle(
                                    height: 1.2,
                                    color: AppColors.primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  // SizedBox(height: 50),

                  // CustomButton(
                  //   onTap: () {
                  //     FocusScope.of(context).unfocus();
                  //     controller.confirmOtp();
                  //   },
                  //   title: "Confirm",
                  //   fontColor: AppColors.whiteColor,
                  // ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
