import 'package:currency_app/feature/currency_converter/bloc/currency_bloc.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_event.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_state.dart';
import 'package:currency_app/feature/currency_converter/ui/components/currency_dropdown.dart';
import 'package:currency_app/models/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FromCurrencyField extends StatelessWidget {
  const FromCurrencyField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CurrencyBloc, CurrencyState, (List<Currency>, String)>(
      selector: (s) => (s.currencies, s.fromCurrency),
      builder: (context, data) {
        return CurrencyDropdown(
          label: 'From',
          currencies: data.$1,
          selectedCode: data.$2,
          onChanged: (code) =>
              context.read<CurrencyBloc>().add(FromCurrencyChanged(code)),
        );
      },
    );
  }
}
