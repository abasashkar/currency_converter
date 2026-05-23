import 'package:currency_app/models/currency.dart';

class CurrencyDto {
  const CurrencyDto({
    required this.code,
    required this.name,
  });

  factory CurrencyDto.fromJsonEntry(String code, dynamic value) {
    final name = value is String ? value : code;
    return CurrencyDto(code: code.toLowerCase(), name: name);
  }

  final String code;
  final String name;

  Currency toModel() => Currency(code: code, name: name);

  static List<CurrencyDto> listFromJson(Map<String, dynamic> json) {
    return json.entries
        .map((e) => CurrencyDto.fromJsonEntry(e.key, e.value))
        .toList()
      ..sort((a, b) => a.code.compareTo(b.code));
  }
}
