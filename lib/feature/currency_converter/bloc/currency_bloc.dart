import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:currency_app/common/constants/app_constants.dart';
import 'package:currency_app/common/extensions/string_extensions.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_event.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_state.dart';
import 'package:currency_app/repo/currency_repository.dart';
import 'package:currency_app/utils/exceptions/app_exceptions.dart';
import 'package:currency_app/utils/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc(this._repository)
      : super(
          const CurrencyState(
            fromCurrency: AppConstants.defaultFromCurrency,
            toCurrency: AppConstants.defaultToCurrency,
            amount: AppConstants.defaultAmount,
          ),
        ) {
    on<LoadCurrencies>(_onLoadCurrencies, transformer: droppable());
    on<FromCurrencyChanged>(_onFromCurrencyChanged);
    on<ToCurrencyChanged>(_onToCurrencyChanged);
    on<AmountChanged>(_onAmountChanged);
    on<SwapCurrencies>(_onSwapCurrencies);
    on<ConvertCurrency>(_onConvertCurrency, transformer: restartable());
  }

  final CurrencyRepository _repository;

  Future<void> _onLoadCurrencies(
    LoadCurrencies event,
    Emitter<CurrencyState> emit,
  ) async {
    emit(
      state.copyWith(
        status: CurrencyStatus.loading,
        errorMessage: null,
      ),
    );

    try {
      final currencies = await _repository.getCurrencies();
      if (isClosed) return;

      if (currencies.isEmpty) {
        emit(
          state.copyWith(
            status: CurrencyStatus.empty,
            currencies: currencies,
            errorMessage: 'No currencies available',
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          status: CurrencyStatus.success,
          currencies: List.unmodifiable(currencies),
          errorMessage: null,
          conversionStatus: ConversionStatus.idle,
          clearConversionResult: true,
        ),
      );
    } on AppException catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: CurrencyStatus.error,
          errorMessage: e.message,
        ),
      );
    } catch (_) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: CurrencyStatus.error,
          errorMessage: 'Failed to load currencies',
        ),
      );
    }
  }

  void _onFromCurrencyChanged(
    FromCurrencyChanged event,
    Emitter<CurrencyState> emit,
  ) {
    final code = event.currencyCode.normalizeCurrencyCode();
    if (code == state.fromCurrency) return;

    emit(
      state.copyWith(
        fromCurrency: code,
        clearConversionResult: true,
        conversionStatus: ConversionStatus.idle,
        conversionErrorMessage: null,
      ),
    );
  }

  void _onToCurrencyChanged(
    ToCurrencyChanged event,
    Emitter<CurrencyState> emit,
  ) {
    final code = event.currencyCode.normalizeCurrencyCode();
    if (code == state.toCurrency) return;

    emit(
      state.copyWith(
        toCurrency: code,
        clearConversionResult: true,
        conversionStatus: ConversionStatus.idle,
        conversionErrorMessage: null,
      ),
    );
  }

  void _onAmountChanged(
    AmountChanged event,
    Emitter<CurrencyState> emit,
  ) {
    final validationError = Validators.validateAmount(event.amount);

    emit(
      state.copyWith(
        amount: event.amount,
        amountValidationError: validationError,
        clearConversionResult: true,
        conversionStatus: ConversionStatus.idle,
        conversionErrorMessage: null,
      ),
    );
  }

  void _onSwapCurrencies(
    SwapCurrencies event,
    Emitter<CurrencyState> emit,
  ) {
    emit(
      state.copyWith(
        fromCurrency: state.toCurrency,
        toCurrency: state.fromCurrency,
        clearConversionResult: true,
        conversionStatus: ConversionStatus.idle,
        conversionErrorMessage: null,
      ),
    );
  }

  Future<void> _onConvertCurrency(
    ConvertCurrency event,
    Emitter<CurrencyState> emit,
  ) async {
    if (state.status != CurrencyStatus.success) return;

    final fromCurrency = state.fromCurrency;
    final toCurrency = state.toCurrency;
    final amountText = state.amount;

    final validationError = Validators.validateAmount(amountText);
    if (validationError != null) {
      emit(
        state.copyWith(
          amountValidationError: validationError,
          conversionStatus: ConversionStatus.error,
          conversionErrorMessage: validationError,
        ),
      );
      return;
    }

    final amount = Validators.parseAmount(amountText);

    emit(
      state.copyWith(
        conversionStatus: ConversionStatus.loading,
        conversionErrorMessage: null,
        amountValidationError: null,
      ),
    );

    try {
      final result = await _repository.convert(
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
        amount: amount,
      );

      if (isClosed) return;

      if (state.fromCurrency != fromCurrency ||
          state.toCurrency != toCurrency ||
          state.amount != amountText) {
        return;
      }

      emit(
        state.copyWith(
          conversionStatus: ConversionStatus.success,
          conversionResult: result,
          conversionErrorMessage: null,
        ),
      );
    } on AppException catch (e) {
      if (isClosed) return;
      if (!_matchesRequest(fromCurrency, toCurrency, amountText)) return;

      emit(
        state.copyWith(
          conversionStatus: ConversionStatus.error,
          conversionErrorMessage: e.message,
        ),
      );
    } catch (_) {
      if (isClosed) return;
      if (!_matchesRequest(fromCurrency, toCurrency, amountText)) return;

      emit(
        state.copyWith(
          conversionStatus: ConversionStatus.error,
          conversionErrorMessage: 'Conversion failed. Please try again.',
        ),
      );
    }
  }

  bool _matchesRequest(String from, String to, String amount) =>
      state.fromCurrency == from &&
      state.toCurrency == to &&
      state.amount == amount;
}
