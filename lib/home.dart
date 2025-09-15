import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/di/translation_provider.dart';
import 'package:pakkahishab/shared/global_widgets/custom_button.dart';

import 'package:pakkahishab/l10n/app_localizations.dart';

class Home extends ConsumerWidget {
  const Home({super.key});
   
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translation = ref.watch(translationProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              // toggle between English and Bangla
              if (translation.appLocale.languageCode == 'en') {
                ref.read(translationProvider).changeLanguage(const Locale('bn'));
              } else {
                ref.read(translationProvider).changeLanguage(const Locale('en'));
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Builder(
          builder: (context) => CustomButton(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("sdjfk")),
              );
            },
            title: AppLocalizations.of(context)!.accountService,
          ),
        ),
      ),
    );
  }
}
