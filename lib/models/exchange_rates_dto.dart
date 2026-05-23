class ExchangeRatesDto {
  const ExchangeRatesDto({
    required this.baseCurrency,
    required this.rates,
    this.date,
  });

  factory ExchangeRatesDto.fromJson(
    Map<String, dynamic> json,
    String baseCurrency,
  ) {
    final base = baseCurrency.toLowerCase();
    final ratesRaw = json[base];

    if (ratesRaw is! Map) {
      throw FormatException('Missing rates for base currency: $base');
    }

    final rates = <String, double>{};
    ratesRaw.forEach((key, value) {
      if (value is num) {
        rates[key.toString().toLowerCase()] = value.toDouble();
      }
    });

    return ExchangeRatesDto(
      baseCurrency: base,
      rates: rates,
      date: json['date']?.toString(),
    );
  }

  final String baseCurrency;
  final Map<String, double> rates;
  final String? date;

  double? rateFor(String targetCurrency) {
    return rates[targetCurrency.toLowerCase()];
  }
}
