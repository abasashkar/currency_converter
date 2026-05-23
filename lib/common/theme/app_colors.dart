import 'package:flutter/material.dart';
abstract final class AppColors {
  static const Color indigo = Color(0xFF6366F1);
  static const Color indigoDeep = Color(0xFF4F46E5);
  static const Color violet = Color(0xFF8B5CF6);
  static const Color teal = Color(0xFF14B8A6);
  static const Color tealBright = Color(0xFF2DD4BF);
  static const Color gold = Color(0xFFF59E0B);
  static const Color lightBgTop = Color(0xFFF8FAFC);
  static const Color lightBgBottom = Color(0xFFEEF2FF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardBorder = Color(0xFFE2E8F0);
  static const Color lightInputFill = Color(0xFFF1F5F9);
  static const Color darkBgTop = Color(0xFF0F172A);
  static const Color darkBgBottom = Color(0xFF1E1B4B);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkCardElevated = Color(0xFF334155);
  static const Color darkCardBorder = Color(0xFF475569);
  static const Color darkInputFill = Color(0xFF1E293B);
  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  static LinearGradient scaffoldGradient(BuildContext context) {
    final dark = isDark(context);
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: dark
          ? [darkBgTop, darkBgBottom, const Color(0xFF312E81)]
          : [lightBgTop, lightBgBottom, const Color(0xFFE0E7FF)],
      stops: const [0.0, 0.55, 1.0],
    );
  }
  static LinearGradient primaryButtonGradient(BuildContext context) {
    final dark = isDark(context);
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: dark
          ? [indigo, violet, tealBright]
          : [indigoDeep, indigo, violet],
    );
  }
  static LinearGradient resultCardGradient(BuildContext context) {
    final dark = isDark(context);
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: dark
          ? [
              indigoDeep.withValues(alpha: 0.9),
              const Color(0xFF312E81),
              teal.withValues(alpha: 0.35),
            ]
          : [
              indigoDeep,
              indigo,
              violet.withValues(alpha: 0.85),
            ],
    );
  }
  static LinearGradient heroTextGradient(BuildContext context) {
    final dark = isDark(context);
    return LinearGradient(
      colors: dark
          ? [Colors.white, tealBright]
          : [const Color(0xFF1E293B), indigoDeep],
    );
  }
  static LinearGradient swapButtonGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: isDark(context)
          ? [indigo, violet]
          : [indigo, indigoDeep],
    );
  }
  static List<BoxShadow> cardShadow(BuildContext context) {
    final dark = isDark(context);
    return [
      BoxShadow(
        color: (dark ? Colors.black : indigo).withValues(alpha: dark ? 0.35 : 0.08),
        blurRadius: dark ? 24 : 20,
        offset: const Offset(0, 8),
      ),
      if (!dark)
        BoxShadow(
          color: indigo.withValues(alpha: 0.06),
          blurRadius: 40,
          offset: const Offset(0, 16),
        ),
    ];
  }
  static Color cardSurface(BuildContext context) =>
      isDark(context) ? darkCard : lightCard;
  static Color cardBorder(BuildContext context) =>
      isDark(context) ? darkCardBorder : lightCardBorder;
  static Color inputFill(BuildContext context) =>
      isDark(context) ? darkInputFill : lightInputFill;
}
