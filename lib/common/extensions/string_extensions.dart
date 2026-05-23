extension StringExtensions on String {
  String get displayCode => toUpperCase();
  String normalizeCurrencyCode() => toLowerCase().trim();
}
