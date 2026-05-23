import 'package:currency_app/common/constants/app_constants.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_bloc.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_event.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_state.dart';
import 'package:currency_app/feature/currency_converter/ui/components/amount_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmountField extends StatefulWidget {
  const AmountField({super.key});

  @override
  State<AmountField> createState() => AmountFieldState();
}

class AmountFieldState extends State<AmountField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: AppConstants.defaultAmount);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrencyBloc, CurrencyState>(
      listenWhen: (prev, curr) =>
          prev.amount != curr.amount && _controller.text != curr.amount,
      listener: (_, state) {
        _controller.value = TextEditingValue(
          text: state.amount,
          selection: TextSelection.collapsed(offset: state.amount.length),
        );
      },
      child: BlocSelector<CurrencyBloc, CurrencyState, String?>(
        selector: (s) => s.amountValidationError,
        builder: (context, validationError) {
          return AmountInputField(
            controller: _controller,
            errorText: validationError,
            onChanged: (value) =>
                context.read<CurrencyBloc>().add(AmountChanged(value)),
          );
        },
      ),
    );
  }
}
