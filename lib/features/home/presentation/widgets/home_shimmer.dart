import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TextShimmer extends StatelessWidget {
  final bool loading;
  final Widget child;
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const TextShimmer({
    super.key,
    required this.loading,
    required this.child,
    this.width = 80,
    this.height = 22,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
  });

  @override
  Widget build(BuildContext context) {
    if (!loading) return child;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,     // 🔹 darker base
      highlightColor: Colors.grey.shade100, // 🔹 lighter shimmer
      period: const Duration(milliseconds: 1200),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}