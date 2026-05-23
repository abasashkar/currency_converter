import 'package:equatable/equatable.dart';
class ApiResponse<T> extends Equatable {
  const ApiResponse({
    required this.data,
    this.message,
    this.statusCode,
  });
  const ApiResponse.failure({
    required this.message,
    this.statusCode,
  }) : data = null;
  final T? data;
  final String? message;
  final int? statusCode;
  bool get isSuccess => data != null;
  @override
  List<Object?> get props => [data, message, statusCode];
}
