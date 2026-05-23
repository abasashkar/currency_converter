import 'package:currency_app/common/constants/api_constants.dart';
import 'package:currency_app/common/extensions/string_extensions.dart';
import 'package:currency_app/common/services/api_client.dart';
import 'package:currency_app/models/conversion_result.dart';
import 'package:currency_app/models/currency.dart';
import 'package:currency_app/models/currency_dto.dart';
import 'package:currency_app/models/exchange_rates_dto.dart';
import 'package:currency_app/utils/exceptions/app_exceptions.dart';
import 'package:currency_app/utils/validators.dart';

class CurrencyRepository {
  CurrencyRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<List<Currency>> getCurrencies() async {
    final dtos = await _fetchCurrencies();
    return dtos.map((d) => d.toModel()).toList();
  }

  Future<ConversionResult> convert({
    required String fromCurrency,
    required String toCurrency,
    required double amount,
  }) async {
    final from = fromCurrency.normalizeCurrencyCode();
    final to = toCurrency.normalizeCurrencyCode();

    if (Validators.isSameCurrency(from, to)) {
      return ConversionResult(
        fromCurrency: from,
        toCurrency: to,
        amount: amount,
        convertedAmount: amount,
        rate: 1,
      );
    }

    final rates = await _fetchExchangeRates(from);
    final rate = rates.rateFor(to);

    if (rate == null) {
      throw CurrencyNotFoundException(
        'Exchange rate not found for $from → $to',
      );
    }

    return ConversionResult(
      fromCurrency: from,
      toCurrency: to,
      amount: amount,
      convertedAmount: amount * rate,
      rate: rate,
      rateDate: rates.date,
    );
  }

  Future<List<CurrencyDto>> _fetchCurrencies() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      path: ApiConstants.currenciesPath,
      parser: (json) {
        if (json is! Map<String, dynamic>) {
          throw const ParseException('Invalid currencies response format');
        }
        return json;
      },
    );

    if (!response.isSuccess || response.data == null) {
      throw NetworkException(
        response.message ?? 'Failed to load currencies',
      );
    }

    return CurrencyDto.listFromJson(response.data!);
  }

  Future<ExchangeRatesDto> _fetchExchangeRates(String baseCurrency) async {
    final code = baseCurrency.toLowerCase();
    final response = await _apiClient.get<Map<String, dynamic>>(
      path: ApiConstants.ratesPath(code),
      parser: (json) {
        if (json is! Map<String, dynamic>) {
          throw const ParseException('Invalid exchange rates response format');
        }
        return json;
      },
    );

    if (!response.isSuccess || response.data == null) {
      throw NetworkException(
        response.message ?? 'Failed to load exchange rates for $code',
      );
    }

    return ExchangeRatesDto.fromJson(response.data!, code);
  }
}
