import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/di/translation_provider.dart';
import 'package:pakkahishab/features/auth/viewmodel/login_viewmodel.dart';
import 'package:pakkahishab/features/auth/widgets/custom_text_field.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';

import 'package:pakkahishab/shared/global_widgets/custom_fullwidth_button.dart';

import '../../../core/const/app_colors.dart';


class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(loginViewModelProvider);
    final translation = ref.watch(translationProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsetsGeometry.only(right: 10),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              onTap: () {
                if (translation.appLocale.languageCode == 'en') {
                  ref
                      .read(translationProvider)
                      .changeLanguage(const Locale('bn'));
                } else {
                  ref
                      .read(translationProvider)
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
                  style: bodyMediumWhite,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          
          children: [
            SizedBox(
              height: 100,
            ),
          
            CustomTextField(
              prefixIcon: Icon(Icons.phone),
              hint: AppLocalizations.of(context)!.phone,
              onChanged: (val) => vm.updatePhone(val),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              prefixIcon: Icon(Icons.password),
              hint: AppLocalizations.of(context)!.password,
              onChanged: (val) => vm.updatePassword(val),
            ),

            const SizedBox(height: 20),

            CustomFullwidthButton(
              onTap: vm.isLoading
                  ? null
                  : () async {
                      final success = await vm.login();
                      if (success && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login Successful")),
                        );
                      } else if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Invalid credentials")),
                        );
                      }
                    },
              title: vm.isLoading
                  ? SizedBox(
                      height: 17,
                      width: 17,
                      child: const CircularProgressIndicator(),
                    )
                  : const Text("Login", style: buttonTextStyle,),
            ),
            const SizedBox(height: 10),
            Divider(color: AppColors.primaryColor),
            const SizedBox(height: 10),
            CustomFullwidthButton(
              onTap: () async {
                Navigator.pushNamed(context, '/signup');
              },
              title: Text("SignUp",style: buttonTextStyle,),
            ),
           
          ],
        ),
      ),
    );
  }
}
