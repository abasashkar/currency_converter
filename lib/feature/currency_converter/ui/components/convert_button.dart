import 'package:currency_app/common/widgets/premium_button.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_bloc.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_event.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertButton extends StatelessWidget {
  const ConvertButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CurrencyBloc, CurrencyState, bool>(
      selector: (s) => s.isConverting,
      builder: (context, isConverting) {
        return PremiumButton(
          label: isConverting ? 'Converting...' : 'Convert',
          isLoading: isConverting,
          icon: const Icon(
            Icons.currency_exchange_rounded,
            color: Colors.white,
            size: 22,
          ),
          onPressed: isConverting
              ? null
              : () => context.read<CurrencyBloc>().add(const ConvertCurrency()),
        );
      },
    );
  }
}
