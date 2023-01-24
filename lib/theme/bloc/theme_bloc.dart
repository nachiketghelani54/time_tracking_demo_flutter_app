import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_demo/theme/theme.dart';
import 'package:time_tracking_demo/theme/theme_helper.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required this.themeHelper}) : super(const LoadingState()) {
    on<FetchThemeFromSharedPref>(_fetchThemeFromSharedPrefEventToState);
    on<ThemeChanged>(_changeThemeEventToState);
  }

  final ThemeHelper themeHelper;

  Future<void> _fetchThemeFromSharedPrefEventToState(
    FetchThemeFromSharedPref event,
    Emitter<ThemeState> emit,
  ) async {
    /// Fetch theme from [SharedPreferences]
    final initialLocale = await themeHelper.theme;

    emit(ThemeSuccess(
        status: initialLocale,
        appTheme: initialLocale ? TaskTheme.darkTheme : TaskTheme.lightTheme));
  }

  Future<void> _changeThemeEventToState(
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    /// Store theme in [SharedPreferences]
    await themeHelper.saveTheme(event.status);
    emit(ThemeSuccess(appTheme: event.theme, status: event.status));
  }
}
