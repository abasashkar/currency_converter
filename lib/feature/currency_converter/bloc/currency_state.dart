import 'package:currency_app/models/conversion_result.dart';
import 'package:currency_app/models/currency.dart';
import 'package:equatable/equatable.dart';

enum CurrencyStatus {
  initial,
  loading,
  success,
  empty,
  error,
}

enum ConversionStatus {
  idle,
  loading,
  success,
  error,
}

const Object _unset = Object();

class CurrencyState extends Equatable {
  const CurrencyState({
    this.status = CurrencyStatus.initial,
    this.conversionStatus = ConversionStatus.idle,
    this.currencies = const [],
    this.fromCurrency = 'usd',
    this.toCurrency = 'eur',
    this.amount = '1',
    this.conversionResult,
    this.errorMessage,
    this.conversionErrorMessage,
    this.amountValidationError, required this.transactions,
    
  });

  final CurrencyStatus status;
  final ConversionStatus conversionStatus;
  final List<Currency> currencies;
  final String fromCurrency;
  final String toCurrency;
  final String amount;
  final ConversionResult? conversionResult;
  final String? errorMessage;
  final String? conversionErrorMessage;
  final String? amountValidationError;
  final List<ConversionResult> transactions;

  bool get hasCurrencies => currencies.isNotEmpty;
  bool get isLoading => status == CurrencyStatus.loading;
  bool get isConverting => conversionStatus == ConversionStatus.loading;

  CurrencyState copyWith({
    CurrencyStatus? status,
    ConversionStatus? conversionStatus,
    List<Currency>? currencies,
    String? fromCurrency,
    String? toCurrency,
    String? amount,
    ConversionResult? conversionResult,
    Object? errorMessage = _unset,
    Object? conversionErrorMessage = _unset,
    Object? amountValidationError = _unset,
    bool clearConversionResult = false,
    List<ConversionResult>? transactions,
  }) {
    return CurrencyState(
      status: status ?? this.status,
      conversionStatus: conversionStatus ?? this.conversionStatus,
      currencies: currencies ?? this.currencies,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      amount: amount ?? this.amount,
      conversionResult:
          clearConversionResult ? null : (conversionResult ?? this.conversionResult),
      errorMessage:
          errorMessage == _unset ? this.errorMessage : errorMessage as String?,
      conversionErrorMessage: conversionErrorMessage == _unset
          ? this.conversionErrorMessage
          : conversionErrorMessage as String?,
      amountValidationError: amountValidationError == _unset
          ? this.amountValidationError
          : amountValidationError as String?, transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object?> get props => [
        status,
        conversionStatus,
        fromCurrency,
        toCurrency,
        amount,
        conversionResult,
        errorMessage,
        conversionErrorMessage,
        amountValidationError,
        currencies,
        transactions,
      ];
}
