import 'package:currency_app/common/constants/app_constants.dart';
import 'package:currency_app/common/widgets/empty_state_widget.dart';
import 'package:currency_app/common/widgets/error_state_widget.dart';
import 'package:currency_app/common/widgets/loading_indicator.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_bloc.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_event.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_state.dart';
import 'package:currency_app/feature/currency_converter/ui/components/success_scroll_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyBody extends StatelessWidget {
  const CurrencyBody({super.key, this.constrainWidth = false});

  final bool constrainWidth;

  @override
  Widget build(BuildContext context) {
    final content = BlocSelector<CurrencyBloc, CurrencyState, CurrencyStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        return switch (status) {
          CurrencyStatus.initial || CurrencyStatus.loading =>
            const LoadingIndicator(message: 'Loading currencies...'),
          CurrencyStatus.empty => const EmptyStateWidget(
              title: 'No currencies found',
              subtitle: 'Tap retry to load currencies again',
              icon: Icons.money_off_csred_rounded,
            ),
          CurrencyStatus.error => BlocSelector<CurrencyBloc, CurrencyState,
              String?>(
            selector: (state) => state.errorMessage,
            builder: (context, message) {
              return ErrorStateWidget(
                message: message ?? 'Something went wrong',
                onRetry: () =>
                    context.read<CurrencyBloc>().add(const LoadCurrencies()),
              );
            },
          ),
          CurrencyStatus.success => const SuccessScrollContent(),
        };
      },
    );

    if (!constrainWidth) return content;

    return Center(
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
        child: content,
      ),
    );
  }
}
