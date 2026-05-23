import 'package:currency_app/common/constants/app_constants.dart';
import 'package:currency_app/common/widgets/premium_card.dart';
import 'package:currency_app/feature/currency_converter/ui/components/amount_field.dart';
import 'package:currency_app/feature/currency_converter/ui/components/conversion_result_section.dart';
import 'package:currency_app/feature/currency_converter/ui/components/convert_button.dart';
import 'package:currency_app/feature/currency_converter/ui/components/form_swap_button.dart';
import 'package:currency_app/feature/currency_converter/ui/components/from_currency_field.dart';
import 'package:currency_app/feature/currency_converter/ui/components/to_currency_field.dart';
import 'package:flutter/material.dart';

class ConverterFormCard extends StatelessWidget {
  const ConverterFormCard({super.key});

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FromCurrencyField(),
          const SizedBox(height: 4),
          const FormSwapButton(),
          const SizedBox(height: 4),
          const ToCurrencyField(),
          const SizedBox(height: 28),
          const AmountField(),
          const SizedBox(height: 28),
          const ConvertButton(),
          const SizedBox(height: 28),
          const ConversionResultSection(),
        ],
      ),
    );
  }
}
