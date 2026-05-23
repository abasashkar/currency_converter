import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);
  void toggle(Brightness platformBrightness) {
    final effective = state == ThemeMode.system
        ? (platformBrightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light)
        : state;
    emit(
      effective == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
    );
  }
}
