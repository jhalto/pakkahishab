import 'package:flutter/material.dart';
import 'package:pakkahishab/features/auth/presentation/view/login_view.dart';
import 'package:pakkahishab/features/auth/presentation/view/signup_view.dart';
import 'package:pakkahishab/features/home/presentation/views/home_view.dart';
import 'package:pakkahishab/home.dart';

class Routes {
  static const String home = '/home';
  static const String signup = '/signup';
  static const String login = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView(),);  
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupView());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text("Route not found")),
                ));
    }
  }
}