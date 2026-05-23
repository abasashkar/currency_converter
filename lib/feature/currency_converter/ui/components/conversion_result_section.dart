import 'package:currency_app/feature/currency_converter/bloc/currency_bloc.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_state.dart';
import 'package:currency_app/feature/currency_converter/ui/components/conversion_result_card.dart';
import 'package:currency_app/models/conversion_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversionResultSection extends StatelessWidget {
  const ConversionResultSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CurrencyBloc, CurrencyState,
        (ConversionStatus, ConversionResult?, String?)>(
      selector: (s) =>
          (s.conversionStatus, s.conversionResult, s.conversionErrorMessage),
      builder: (context, data) {
        return ConversionResultCard(
          conversionStatus: data.$1,
          result: data.$2,
          errorMessage: data.$3,
        );
      },
    );
  }
}
