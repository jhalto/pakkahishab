import 'package:flutter/material.dart';
import 'package:pakkahishab/core/const/app_colors.dart';

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Gradient? gradient;

  const GradientIcon({
    super.key,
    required this.icon,
    required this.size,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final defaultGradient = const LinearGradient(
      colors: [
        AppColors.primaryColor2, // Sky blue
        AppColors.primaryColor, // Deep blue
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return ShaderMask(
      shaderCallback: (bounds) => (gradient ?? defaultGradient).createShader(
        Rect.fromLTWH(0, 0, size, size),
      ),
      blendMode: BlendMode.srcIn,
      child: Icon(icon, size: size, color: Colors.white),
    );
  }
}
