import 'package:flutter/material.dart';
import 'package:pakkahishab/features/auth/presentation/view/login_view.dart';
import 'package:pakkahishab/features/auth/presentation/view/signup_view.dart';
import 'package:pakkahishab/features/customer_due/presentation/views/customer_dues_view.dart';
import 'package:pakkahishab/features/supplier_due/presentation/views/supplier_dues_view.dart';
import 'package:pakkahishab/features/home/presentation/views/home_view.dart';
import 'package:pakkahishab/features/nav_bar/presentation/view/navbar_view.dart';
import 'package:pakkahishab/features/purchase/presentation/views/purchases_view.dart';
import 'package:pakkahishab/features/sales/presentation/views/sales_view.dart';


class Routes {
  static const String home = '/home';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String navbar = '/navbar';
  static const String purchase = '/purchase';
  static const String sales = '/sales';
  static const String supplierDues = '/supplierDues';
  static const String customerDues = '/customerDues';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView(),);  
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupView());
      case navbar:
        return MaterialPageRoute(builder: (_) => const NavbarView());
      case purchase:
        return MaterialPageRoute(builder: (_) => const PurchasesView());
      case sales:
        return MaterialPageRoute(builder: (_) => const SalesView());
      case supplierDues:
        return MaterialPageRoute(builder: (_) => const SupplierDuesView());
      case customerDues:
        return MaterialPageRoute(builder: (_) => const CustomerDuesView());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text("Route not found")),
                ));
    }
  }
}