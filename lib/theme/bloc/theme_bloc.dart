import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:time_tracking_demo/theme/theme.dart';

import '../../localization/localization_helper.dart';


part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required this.localizationHelper}) : super(const LoadingState()) {
    on<FetchThemeFromSharedPref>(_fetchThemeFromSharedPrefEventToState);
    on<ThemeChanged>(_changeThemeEventToState);
  }

  final LocalizationHelper localizationHelper;

  Future<void> _fetchThemeFromSharedPrefEventToState(
    FetchThemeFromSharedPref event,
    Emitter<ThemeState> emit,
  ) async {
    /// Fetch theme from [SharedPreferences]
    final initialLocale = await localizationHelper.theme;

    emit(ThemeSuccess(
        status: initialLocale,
        appTheme:
            initialLocale ? TaskTheme.darkTheme : TaskTheme.lightTheme));
  }

  Future<void> _changeThemeEventToState(
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    /// Store theme in [SharedPreferences]
    await localizationHelper.saveTheme(event.status);
    emit(ThemeSuccess(appTheme: event.theme, status: event.status));
  }
}
