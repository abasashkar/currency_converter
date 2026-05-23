import 'package:currency_app/feature/currency_converter/bloc/currency_bloc.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_event.dart';
import 'package:currency_app/feature/currency_converter/ui/components/swap_currencies_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormSwapButton extends StatelessWidget {
  const FormSwapButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SwapCurrenciesButton(
      onPressed: () =>
          context.read<CurrencyBloc>().add(const SwapCurrencies()),
    );
  }
}
