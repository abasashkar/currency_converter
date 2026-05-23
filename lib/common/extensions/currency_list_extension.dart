import 'package:currency_app/models/currency.dart';

extension CurrencyListExtension on List<Currency> {
  Currency? byCode(String code) {
    final normalized = code.toLowerCase();
    for (final currency in this) {
      if (currency.code == normalized) return currency;
    }
    return null;
  }
}
