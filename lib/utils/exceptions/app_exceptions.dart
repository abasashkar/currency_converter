import 'package:equatable/equatable.dart';
sealed class AppException extends Equatable implements Exception {
  const AppException(this.message, {this.code});
  final String message;
  final String? code;
  @override
  List<Object?> get props => [message, code];
  @override
  String toString() => message;
}
final class NetworkException extends AppException {
  const NetworkException(super.message, {super.code});
}
final class ParseException extends AppException {
  const ParseException(super.message, {super.code});
}
final class CurrencyNotFoundException extends AppException {
  const CurrencyNotFoundException(super.message, {super.code});
}
final class ValidationException extends AppException {
  const ValidationException(super.message, {super.code});
}
final class CacheException extends AppException {
  const CacheException(super.message, {super.code});
}
