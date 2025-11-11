import 'package:flutter/material.dart';

/// Custom function for smooth page navigation with platform-aware slide animation
Future<T?> navigateWithSlide<T>({
  required BuildContext context,
  required Widget page,
}) {
  final isAndroid = Theme.of(context).platform == TargetPlatform.android;

  return Navigator.push<T>(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final beginOffset = isAndroid ? const Offset(1.0, 0.0) : const Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(begin: beginOffset, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}