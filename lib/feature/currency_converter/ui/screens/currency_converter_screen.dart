import 'package:currency_app/common/extensions/context_extensions.dart';
import 'package:currency_app/common/widgets/gradient_scaffold.dart';
import 'package:currency_app/common/widgets/responsive_builder.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_bloc.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_state.dart';
import 'package:currency_app/feature/currency_converter/ui/components/currency_body.dart';
import 'package:currency_app/feature/currency_converter/ui/components/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyConverterScreen extends StatelessWidget {
  const CurrencyConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        actions: const [
          ThemeToggleButton(),
          SizedBox(width: 8),
        ],
      ),
      body: BlocListener<CurrencyBloc, CurrencyState>(
        listenWhen: (prev, curr) =>
            prev.conversionErrorMessage != curr.conversionErrorMessage &&
            curr.conversionErrorMessage != null &&
            curr.conversionStatus == ConversionStatus.error,
        listener: (context, state) {
          context.showAppSnackBar(
            state.conversionErrorMessage!,
            isError: true,
          );
        },
        child: SafeArea(
          child: ResponsiveBuilder(
            mobile: const CurrencyBody(),
            tablet: const CurrencyBody(constrainWidth: true),
            desktop: const CurrencyBody(constrainWidth: true),
          ),
        ),
      ),
    );
  }
}
