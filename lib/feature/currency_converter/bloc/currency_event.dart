import 'package:equatable/equatable.dart';
sealed class CurrencyEvent extends Equatable {
  const CurrencyEvent();
  @override
  List<Object?> get props => [];
}
final class LoadCurrencies extends CurrencyEvent {
  const LoadCurrencies();
}
final class FromCurrencyChanged extends CurrencyEvent {
  const FromCurrencyChanged(this.currencyCode);
  final String currencyCode;
  @override
  List<Object?> get props => [currencyCode];
}
final class ToCurrencyChanged extends CurrencyEvent {
  const ToCurrencyChanged(this.currencyCode);
  final String currencyCode;
  @override
  List<Object?> get props => [currencyCode];
}
final class AmountChanged extends CurrencyEvent {
  const AmountChanged(this.amount);
  final String amount;
  @override
  List<Object?> get props => [amount];
}
final class SwapCurrencies extends CurrencyEvent {
  const SwapCurrencies();
}
final class ConvertCurrency extends CurrencyEvent {
  const ConvertCurrency();
}
