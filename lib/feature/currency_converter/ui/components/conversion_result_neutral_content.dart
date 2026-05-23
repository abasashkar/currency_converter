import 'package:currency_app/common/theme/app_colors.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_state.dart';
import 'package:flutter/material.dart';

class ConversionResultNeutralContent extends StatelessWidget {
  const ConversionResultNeutralContent({
    super.key,
    required this.conversionStatus,
    this.errorMessage,
  });

  final ConversionStatus conversionStatus;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (conversionStatus == ConversionStatus.loading) {
      return const SizedBox(
        height: 88,
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: AppColors.indigo,
          ),
        ),
      );
    }

    if (conversionStatus == ConversionStatus.error && errorMessage != null) {
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colors.error.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.error_outline_rounded, color: colors.error),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              errorMessage!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: colors.error,
                height: 1.4,
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        Icon(
          Icons.currency_exchange_rounded,
          size: 44,
          color: colors.onSurfaceVariant.withValues(alpha: 0.5),
        ),
        const SizedBox(height: 14),
        Text(
          'Enter an amount to convert',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: colors.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
