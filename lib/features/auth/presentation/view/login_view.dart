import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/const/images_path.dart';
import 'package:pakkahishab/core/di/translation_provider.dart';
import 'package:pakkahishab/features/auth/presentation/viewmodel/login_viewmodel.dart';
import 'package:pakkahishab/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';
import 'package:pakkahishab/routes/app_routes.dart';
import 'package:pakkahishab/shared/global_widgets/custom_fullwidth_button.dart';
import '../../../../core/const/app_colors.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsetsGeometry.only(right: 10),
            child: Consumer(
              builder: (context, ref, child) {
                final translation = ref.watch(translationProvider);
                return InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  onTap: () {
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
                  child: Ink(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppColors.primaryColor,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.languageType,
                      style:AppTextStyle.bodyMediumWhite,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                ImagesPath.logo,
                width: screenWidth * .52,
              ),
            ),
            SizedBox(height: 50),
            Consumer(
              builder: (context, ref, child) {
                print("name build");
                final nameError = ref.watch(
                  loginNotifierProvider.select((vm) => vm.nameError),
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
                          .read(loginNotifierProvider.notifier)
                          .updateName(value, context),
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 2),
                    if (nameError.isNotEmpty)
                      Text(
                        nameError,
                        style: const TextStyle(color: AppColors.errorTextColor),
                      ),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),

            Consumer(
              builder: (context, ref, child) {
                final passwordError = ref.watch(
                  loginNotifierProvider.select((vm) => vm.passwordError),
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
                          .read(loginNotifierProvider.notifier)
                          .updatePassword(value, context),
                      onDone: () async {
                        await ref.read(loginNotifierProvider.notifier).login(context);
                      },
                      textInputAction: TextInputAction.done,
                    ),
                    if (passwordError.isNotEmpty)
                      Text(
                        passwordError,
                        style: const TextStyle(color: AppColors.errorTextColor),
                      ),
                  ],
                );
              },
            ),

            const SizedBox(height: 50),
            Consumer(
              builder: (context, ref, child) {
                final isLoading = ref.watch(
                  loginNotifierProvider.select((vm) => vm.isLoading),
                );
                
                return CustomFullwidthButton(
                  onTap: () async {
                    print("df");
                    await ref.read(loginNotifierProvider.notifier).login(context);
                  },
                  title: "Login",
                  isLoading: isLoading,
                );
              },
            ),

            const SizedBox(height: 10),
            Divider(color: AppColors.primaryColor),
            const SizedBox(height: 10),
            CustomFullwidthButton(
              
              onTap: () async {
                Navigator.pushNamed(context, Routes.signup);
                // Navigator.push(context, MaterialPageRoute(builder: (context) => NumberVerificationView(),));
              },
              title: "SignUp",
            ),
          ],
        ),
      ),
    );
  }
}
