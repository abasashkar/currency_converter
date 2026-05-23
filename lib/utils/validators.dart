import 'package:currency_app/utils/exceptions/app_exceptions.dart';
abstract final class Validators {
  static String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter an amount';
    }
    final parsed = double.tryParse(value.trim().replaceAll(',', ''));
    if (parsed == null) {
      return 'Enter a valid number';
    }
    if (parsed < 0) {
      return 'Amount cannot be negative';
    }
    if (parsed.isInfinite || parsed.isNaN) {
      return 'Amount is not valid';
    }
    return null;
  }
  static double parseAmount(String value) {
    final error = validateAmount(value);
    if (error != null) {
      throw ValidationException(error);
    }
    return double.parse(value.trim().replaceAll(',', ''));
  }
  static bool isSameCurrency(String from, String to) =>
      from.toLowerCase() == to.toLowerCase();
}
