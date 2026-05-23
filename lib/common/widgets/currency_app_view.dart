import 'package:currency_app/common/cubit/theme_cubit.dart';
import 'package:currency_app/common/theme/app_theme.dart';
import 'package:currency_app/feature/currency_converter/ui/screens/currency_converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyAppView extends StatelessWidget {
  const CurrencyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, themeMode) {
        return MaterialApp(
          title: 'Currency Converter',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: themeMode,
          home: const CurrencyConverterScreen(),
        );
      },
    );
  }
}
