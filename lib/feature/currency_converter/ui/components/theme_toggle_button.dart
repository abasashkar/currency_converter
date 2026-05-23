import 'package:currency_app/common/cubit/theme_cubit.dart';
import 'package:currency_app/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: AppColors.cardSurface(context).withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.cardBorder(context).withValues(alpha: 0.5),
        ),
      ),
      child: IconButton(
        tooltip: 'Toggle theme',
        onPressed: () => context.read<ThemeCubit>().toggle(
              MediaQuery.platformBrightnessOf(context),
            ),
        icon: Icon(
          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          size: 22,
        ),
      ),
    );
  }
}
