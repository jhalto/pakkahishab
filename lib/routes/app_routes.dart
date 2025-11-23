import 'package:flutter/material.dart';
import 'package:pakkahishab/features/auth/presentation/view/login_view.dart';
import 'package:pakkahishab/features/auth/presentation/view/signup_view.dart';
import 'package:pakkahishab/features/customer_due/presentation/views/customer_dues_view.dart';
import 'package:pakkahishab/features/expenses/presentation/views/expenses_view.dart';
import 'package:pakkahishab/features/income/presentation/views/income_view.dart';
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
  static const String expenses = '/expenses';
  static const String income = '/income';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;

    switch (settings.name) {
      case home:
        page = const HomeView();
        break;
      case login:
        page = const LoginView();
        break;
      case signup:
        page = const SignupView();
        break;
      case navbar:
        page = const NavbarView();
        break;
      case purchase:
        page = const PurchasesView();
        break;
      case sales:
        page = const SalesView();
        break;
      case supplierDues:
        page = const SupplierDuesView();
        break;
      case customerDues:
        page = const CustomerDuesView();
        break;
      case expenses:
        page = const ExpensesView(); 
        break;
      case income:
        page = const IncomeView(); 
        break;
      default:
        page = const Scaffold(
          body: Center(child: Text("Route not found")),
        );
    }

    return _slideRoute(page);
  }

  /// Slide transition (Android → right; iOS → bottom)
  static PageRouteBuilder _slideRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (_, animation, __) => page,
      transitionsBuilder: (context, animation, __, child) {
        final isAndroid = Theme.of(context).platform == TargetPlatform.android;

        final begin = isAndroid ? const Offset(1.0, 0.0) : const Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}