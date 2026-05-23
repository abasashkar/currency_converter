import 'package:equatable/equatable.dart';

class ConversionResult extends Equatable {
  const ConversionResult({
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
    required this.convertedAmount,
    required this.rate,
    this.rateDate,
  });

  final String fromCurrency;
  final String toCurrency;
  final double amount;
  final double convertedAmount;
  final double rate;
  final String? rateDate;

  @override
  List<Object?> get props => [
        fromCurrency,
        toCurrency,
        amount,
        convertedAmount,
        rate,
        rateDate,
      ];
}
