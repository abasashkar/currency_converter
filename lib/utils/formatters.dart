abstract final class Formatters {
  static String formatAmount(double value) {
    if (value == value.roundToDouble() && value.abs() < 1e15) {
      return value.toStringAsFixed(0);
    }
    final formatted = value.toStringAsFixed(8);
    return formatted
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }
  static String formatRate(double rate) {
    if (rate >= 1) {
      return rate.toStringAsFixed(4);
    }
    return rate.toStringAsFixed(6);
  }
}
