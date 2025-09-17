import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/utils/show_snackbar.dart';
import 'package:pakkahishab/features/auth/presentation/viewmodel/signup_viewmodel.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';
import 'package:pakkahishab/shared/global_widgets/custom_back_button.dart';
import 'package:pakkahishab/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:pakkahishab/shared/global_widgets/custom_fullwidth_button.dart';
import '../../../../core/const/app_colors.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    print("build");
    
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomBackButton(),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/logo/pakkahishab_logo.png",
                  width: screenWidth * .52,
                ),
              ),
              SizedBox(height: 50),
              Consumer(
                builder: (context, ref, child) {
                  print("company build");

                  final vm = ref.watch(
                    signupViewModelProvider.select((vm) => vm.companyError),
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
                            .read(signupViewModelProvider)
                            .updateCompany(value, context),
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 2),
                      if (vm.isNotEmpty)
                        Text(
                          vm,
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
                    signupViewModelProvider.select((vm) => vm.nameError),
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
                            .read(signupViewModelProvider)
                            .updateName(value, context),
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 2),
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
                    signupViewModelProvider.select((vm) => vm.phoneError),
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
                            .read(signupViewModelProvider)
                            .updatePhone(value, context),
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
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, child) {
                  print("email build");
                  final emailError = ref.watch(
                    signupViewModelProvider.select((vm) => vm.emailError),
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
                            .read(signupViewModelProvider)
                            .updateEmail(value, context),
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 2),
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
                    signupViewModelProvider.select((vm) => vm.passwordError),
                  );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        isPassword: true,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: AppColors.primaryColor,
                        ),
                        hint: AppLocalizations.of(context)!.password,
                        onChanged: (value) => ref
                            .read(signupViewModelProvider)
                            .updatePassword(value, context),
                        onDone: () async {
                          await ref
                              .read(signupViewModelProvider)
                              .register(context);
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
              SizedBox(height: 30),
              Consumer(
                builder: (context, ref, child) {
                  final isLoading = ref.watch(
                    signupViewModelProvider.select((vm) => vm.isLoading),
                  );
                  return CustomFullwidthButton(
                    onTap: isLoading
                        ? null
                        : () async {
                            await ref
                                .read(signupViewModelProvider)
                                .register(context);
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
