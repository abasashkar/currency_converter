import 'package:currency_app/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CurrencyAvatar extends StatelessWidget {
  const CurrencyAvatar({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    final label = code.length <= 3 ? code : code.substring(0, 3);

    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: AppColors.primaryButtonGradient(context),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.indigo.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }
}
