import 'package:currency_app/feature/currency_converter/ui/components/conversion_rate_row.dart';
import 'package:currency_app/models/conversion_result.dart';
import 'package:currency_app/utils/formatters.dart';
import 'package:flutter/material.dart';

class ConversionResultSuccessContent extends StatelessWidget {
  const ConversionResultSuccessContent({super.key, required this.result, required this.transactions});

  final ConversionResult result;
  final List<ConversionResult> transactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'CONVERTED AMOUNT',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.4,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 8 * (1 - value)),
                child: child,
              ),
            );
          },
          child: Text(
            '${Formatters.formatAmount(result.convertedAmount)} ${result.toCurrency.toUpperCase()}',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.8,
              height: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(height: 1, color: Colors.white.withValues(alpha: 0.2)),
        const SizedBox(height: 16),
        ConversionRateRow(
          label: 'You send',
          value:
              '${Formatters.formatAmount(result.amount)} ${result.fromCurrency.toUpperCase()}',
        ),
        const SizedBox(height: 10),
        ConversionRateRow(
          label: 'Exchange rate',
          value:
              '1 ${result.fromCurrency.toUpperCase()} = ${Formatters.formatRate(result.rate)} ${result.toCurrency.toUpperCase()}',
        ),
        if (result.rateDate != null) ...[
          const SizedBox(height: 10),
          ConversionRateRow(
            label: 'Rate date',
            value: result.rateDate!,
          ),
          
        ],
        const SizedBox(height: 48),
        Text(
          'Conversion history',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),

        ),

        SizedBox(
          height: 100,
          child: ListView.builder(itemCount: transactions.length,itemBuilder: (context, index){
          
            return ConversionRateRow(
          
              label: '${transactions[index].fromCurrency.toUpperCase()} to ${transactions[index].toCurrency.toUpperCase()}',
              value: '${result.amount.toStringAsFixed(2)} to ${transactions[index].convertedAmount.toStringAsFixed(2)}',
            );
          },
          ),
        ),
      ],
      
    );

  }
}
