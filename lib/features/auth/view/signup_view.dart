import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/features/auth/viewmodel/signup_viewmodel.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';
import 'package:pakkahishab/shared/global_widgets/custom_back_button.dart';
import 'package:pakkahishab/features/auth/widgets/custom_text_field.dart';
import 'package:pakkahishab/shared/global_widgets/custom_fullwidth_button.dart';
import '../../../core/const/app_colors.dart';

class SignupView extends ConsumerWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(signupViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomBackButton(),
              CustomTextField(
                prefixIcon: const Icon(
                  Icons.business,
                  color: AppColors.primaryColor,
                ),
                hint: AppLocalizations.of(context)!.company,
                onChanged: vm.updateCompany,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 2),

              if (vm.companyError.isNotEmpty)
                Text(
                  vm.companyError,
                  style: TextStyle(color: AppColors.errorTextColor),
                ),

              const SizedBox(height: 16),

              CustomTextField(
                prefixIcon: const Icon(
                  Icons.person,
                  color: AppColors.primaryColor,
                ),
                hint: AppLocalizations.of(context)!.name,
                onChanged: vm.updateName,
                textInputAction: TextInputAction.next,
              ),

              SizedBox(height: 2),

              if (vm.nameError.isNotEmpty)
                Text(
                  vm.nameError,
                  style: TextStyle(color: AppColors.errorTextColor),
                ),

              const SizedBox(height: 20),
              CustomTextField(
                prefixIcon: const Icon(
                  Icons.phone,
                  color: AppColors.primaryColor,
                ),
                hint: AppLocalizations.of(context)!.phone,

                onChanged: vm.updatePhone,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 2),
              if (vm.phoneError.isNotEmpty)
                Text(
                  vm.phoneError,
                  style: TextStyle(color: AppColors.errorTextColor),
                ),
              const SizedBox(height: 20),
              CustomTextField(
                prefixIcon: Icon(Icons.email, color: AppColors.primaryColor),
                hint: AppLocalizations.of(context)!.email,
                onChanged: vm.updateEmail,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 2),
              if (vm.emailError.isNotEmpty)
                Text(
                  vm.emailError,
                  style: TextStyle(color: AppColors.errorTextColor),
                ),
              const SizedBox(height: 20),
              // Password
              CustomTextField(
                onDone: () async {
                  final success = await vm.register();
                  if (!context.mounted) return;
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Registration Successful")),
                    );
                  }
                },
                isPassword: true,
                prefixIcon: const Icon(
                  Icons.lock,
                  color: AppColors.primaryColor,
                ),
                hint: AppLocalizations.of(context)!.password,

                onChanged: vm.updatePassword,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 2),
              if (vm.passwordError.isNotEmpty)
                Text(
                  vm.passwordError,
                  style: TextStyle(color: AppColors.errorTextColor),
                ),
              const SizedBox(height: 20),

              // Submit
              CustomFullwidthButton(
                onTap: vm.isLoading
                    ? null
                    : () async {
                        final success = await vm.register();
                        if (!context.mounted) return;
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Registration Successful"),
                            ),
                          );
                        }
                      },
                title: vm.isLoading
                    ? SizedBox(
                        height: 23,
                        width: 23,
                        child: const CircularProgressIndicator(
                          color: AppColors.primaryColor4,
                        ),
                      )
                    : Text("SignUp", style: buttonTextStyle(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
