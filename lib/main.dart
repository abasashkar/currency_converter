import 'package:currency_app/common/cubit/theme_cubit.dart';
import 'package:currency_app/common/widgets/currency_app_view.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_bloc.dart';
import 'package:currency_app/feature/currency_converter/bloc/currency_event.dart';
import 'package:currency_app/repo/currency_repository.dart';
import 'package:currency_app/utils/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const CurrencyApp());
}

class CurrencyApp extends StatelessWidget {
  const CurrencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(
          create: (_) => CurrencyBloc(sl<CurrencyRepository>())
            ..add(const LoadCurrencies()),
        ),
      ],
      child: const CurrencyAppView(),
    );
  }
}
