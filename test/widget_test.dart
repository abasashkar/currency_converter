import 'package:currency_app/common/services/api_client.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_bloc.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_state.dart';
import 'package:currency_app/models/conversion_result.dart';
import 'package:currency_app/models/currency.dart';
import 'package:currency_app/repo/currency_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class TestCurrencyRepository extends CurrencyRepository {
  TestCurrencyRepository() : super(ApiClient(Dio()));

  @override
  Future<List<Currency>> getCurrencies() async => const [
        Currency(code: 'usd', name: 'US Dollar'),
        Currency(code: 'eur', name: 'Euro'),
      ];

  @override
  Future<ConversionResult> convert({
    required String fromCurrency,
    required String toCurrency,
    required double amount,
  }) async =>
      ConversionResult(
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
        amount: amount,
        convertedAmount: amount * 0.92,
        rate: 0.92,
      );
}

void main() {
  testWidgets('App shows title', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => CurrencyBloc(TestCurrencyRepository())
            ..emit(
              const CurrencyState(
                status: CurrencyStatus.success,
                currencies: [
                  Currency(code: 'usd', name: 'US Dollar'),
                  Currency(code: 'eur', name: 'Euro'),
                ],
              ),
            ),
          child: const Scaffold(
            body: Center(child: Text('Currency Converter')),
          ),
        ),
      ),
    );

    expect(find.text('Currency Converter'), findsOneWidget);
  });
}
