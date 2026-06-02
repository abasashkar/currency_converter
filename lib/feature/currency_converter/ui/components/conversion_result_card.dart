import 'package:currency_app/feature/currency_converter/bloc/currency_state.dart';
import 'package:currency_app/feature/currency_converter/ui/components/conversion_result_shell.dart';
import 'package:currency_app/models/conversion_result.dart';
import 'package:flutter/material.dart';

class ConversionResultCard extends StatelessWidget {
  const ConversionResultCard({
    super.key,
    required this.conversionStatus,
    this.result,
    this.errorMessage,
    required this.transactions,

  });
  final List<ConversionResult> transactions;
  final ConversionStatus conversionStatus;
  final ConversionResult? result;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.96, end: 1).animate(animation),
            child: child,
          ),
        );
      },
      child: ConversionResultShell(
        transactions: transactions,
        key: ValueKey('$conversionStatus-${result?.convertedAmount}'),
        conversionStatus: conversionStatus,
        result: result,
        errorMessage: errorMessage,
      ),
    );
  }
}
