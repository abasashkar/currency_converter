abstract final class ApiConstants {
  static const String primaryBaseUrl =
      'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1';
  static const String fallbackBaseUrl =
      'https://latest.currency-api.pages.dev/v1';
  static const String currenciesPath = '/currencies.json';
  static String ratesPath(String currencyCode) =>
      '/currencies/${currencyCode.toLowerCase()}.json';
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
