import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/core/helper/shared_preferences_helper.dart';
import 'package:pakkahishab/routes/app_routes.dart';

final splashViewModel =
    NotifierProvider.autoDispose<SplashNotifier, SplashState>(
      () => SplashNotifier(),
    );

class SplashState {
  final String phone;

  SplashState({ this.phone = ''});

  SplashState copyWith({String? phone}) {
    return SplashState(
    
      phone: phone ?? this.phone,
    );
  }
}

class SplashNotifier extends Notifier<SplashState> {


  @override
  SplashState build() {
  
    return SplashState();
  }

  Future<void> isLogin(BuildContext context) async {
    final phone = await SharedPreferencesHelper.getString('phone');
    final pin = await SharedPreferencesHelper.getString('pin');
    final code = await SharedPreferencesHelper.getString('code');

    if (phone != null && pin != null && code != null) {
      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, Routes.home);
    } else {
      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, Routes.login);
    }
  }
}
