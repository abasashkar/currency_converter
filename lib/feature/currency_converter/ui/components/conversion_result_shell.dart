import 'package:currency_app/common/theme/app_colors.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_state.dart';
import 'package:currency_app/feature/currency_converter/ui/components/conversion_result_neutral_content.dart';
import 'package:currency_app/feature/currency_converter/ui/components/conversion_result_success_content.dart';
import 'package:currency_app/models/conversion_result.dart';
import 'package:flutter/material.dart';

class ConversionResultShell extends StatelessWidget {
  const ConversionResultShell({

    super.key,
    required this.conversionStatus,
    this.result,
    this.errorMessage,
    required this.transactions
  });

  final ConversionStatus conversionStatus;
  final ConversionResult? result;
  final String? errorMessage;
  final List<ConversionResult> transactions;

  bool get _hasSuccess =>
      conversionStatus == ConversionStatus.success && result != null;

  @override
  Widget build(BuildContext context) {
    if (_hasSuccess) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: AppColors.resultCardGradient(context),
          boxShadow: [
            BoxShadow(
              color: AppColors.indigo.withValues(alpha: 0.35),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ConversionResultSuccessContent(result: result!,transactions: transactions,),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: AppColors.cardSurface(context).withValues(alpha: 0.6),
        border: Border.all(
          color: AppColors.cardBorder(context).withValues(alpha: 0.5),
        ),
      ),
      child: ConversionResultNeutralContent(
        conversionStatus: conversionStatus,
        errorMessage: errorMessage,
      ),
    );
  }
}
