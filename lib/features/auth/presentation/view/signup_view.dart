import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/auth/presentation/viewmodel/signup_viewmodel.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';
import 'package:pakkahishab/shared/global_widgets/custom_back_button.dart';
import 'package:pakkahishab/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:pakkahishab/shared/global_widgets/custom_fullwidth_button.dart';
import 'package:pakkahishab/core/const/app_colors.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               CustomBackButton(
                color: Colors.black,
               ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/logo/pakkahishab_logo.png",
                  width: screenWidth * .52,
                ),
              ),
              const SizedBox(height: 50),
              Consumer(
                builder: (context, ref, child) {
                  print("company build");

                  final companyError = ref.watch(
                    signupNotifierProvider.select((vm) => vm.companyNameError),
                  );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        prefixIcon: const Icon(
                          Icons.business,
                          color: AppColors.primaryColor,
                        ),
                        hint: AppLocalizations.of(context)!.company,
                        onChanged: (value) => ref
                            .read(signupNotifierProvider.notifier)
                            .updateCompany(value, context),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 2),
                      if (companyError.isNotEmpty)
                        Text(
                          companyError,
                          style: const TextStyle(
                            color: AppColors.errorTextColor,
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, child) {
                  print("name build");
                  final nameError = ref.watch(
                    signupNotifierProvider.select((vm) => vm.nameError),
                  );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        prefixIcon: const Icon(
                          Icons.person_2,
                          color: AppColors.primaryColor,
                        ),
                        hint: AppLocalizations.of(context)!.name,
                        onChanged: (value) => ref
                            .read(signupNotifierProvider.notifier)
                            .updateName(value, context),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 2),
                      if (nameError.isNotEmpty)
                        Text(
                          nameError,
                          style: const TextStyle(
                            color: AppColors.errorTextColor,
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
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
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: AppColors.primaryColor,
                        ),
                        hint: AppLocalizations.of(context)!.phone,
                        onChanged: (value) => ref
                            .read(signupNotifierProvider.notifier)
                            .updatePhone(value, context),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 2),
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
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, child) {
                  print("email build");
                  final emailError = ref.watch(
                    signupNotifierProvider.select((vm) => vm.emailError),
                  );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        prefixIcon: const Icon(
                          Icons.email,
                          color: AppColors.primaryColor,
                        ),
                        hint: AppLocalizations.of(context)!.email,
                        onChanged: (value) => ref
                            .read(signupNotifierProvider.notifier)
                            .updateEmail(value, context),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 2),
                      if (emailError.isNotEmpty)
                        Text(
                          emailError,
                          style: const TextStyle(
                            color: AppColors.errorTextColor,
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, child) {
                  final passwordError = ref.watch(
                    signupNotifierProvider.select((vm) => vm.passwordError),
                  );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        textInputType: TextInputType.phone,
                        isPassword: true,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: AppColors.primaryColor,
                        ),
                        hint: AppLocalizations.of(context)!.pin,
                        onChanged: (value) => ref
                            .read(signupNotifierProvider.notifier)
                            .updatePassword(value, context),
                        onDone: () async {
                          await ref
                              .read(signupNotifierProvider.notifier)
                              .verifyNumber(context);
                        },
                        textInputAction: TextInputAction.done,
                      ),
                      if (passwordError.isNotEmpty)
                        Text(
                          passwordError,
                          style: const TextStyle(
                            color: AppColors.errorTextColor,
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              Consumer(
                builder: (context, ref, child) {
                  final isLoading = ref.watch(
                    signupNotifierProvider.select((vm) => vm.isLoading),
                  );
                  return CustomFullwidthButton(
                    onTap: isLoading
                        ? null
                        : () async {
                            await ref
                                .read(signupNotifierProvider.notifier)
                                .verifyNumber(context);
                          },
                    title: "SignUp",
                    isLoading: isLoading,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
