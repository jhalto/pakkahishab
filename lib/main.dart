import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/di/translation_provider.dart';
import 'package:pakkahishab/l10n/app_localizations.dart';
import 'package:pakkahishab/routes/app_routes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translation = ref.watch(translationProvider);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          title: 'PakkaHishab',
          debugShowCheckedModeBanner: false,
          locale: translation.appLocale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('bn'), 
          ],
          
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.bgColor, // AppBar background
              foregroundColor: Colors.black, // AppBar text & icons
              elevation: 0, // Optional: remove shadow
              centerTitle: true, // Optional: center the title
            ),
            scaffoldBackgroundColor: AppColors.bgColor,
            textTheme: TextTheme(bodyMedium:AppTextStyle.bodyMedium),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          initialRoute: Routes.navbar,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}
