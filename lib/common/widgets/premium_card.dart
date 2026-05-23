import 'package:currency_app/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
class PremiumCard extends StatelessWidget {
  const PremiumCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.margin,
    this.borderRadius = 24,
    this.gradient,
  });
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Gradient? gradient;
  @override
  Widget build(BuildContext context) {
    final borderColor = AppColors.cardBorder(context).withValues(alpha: 0.6);
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: gradient,
        color: gradient == null ? AppColors.cardSurface(context) : null,
        border: Border.all(color: borderColor, width: 1),
        boxShadow: AppColors.cardShadow(context),
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}
