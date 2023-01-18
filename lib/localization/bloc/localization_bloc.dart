import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../localization_helper.dart';

part 'localization_event.dart';

part 'localization_state.dart';

/// Localization BLoC Class for listen events of Localization
class LocalizationsBloc extends Bloc<LocalizationsEvent, LocalizationsState> {
  LocalizationsBloc({required this.localizationHelper})
      : super(const LoadingState()) {
    on<FetchLocaleFromSharedPref>(_fetchLocaleFromSharedPrefEventToState);
    on<ChangeLocale>(_changeLocaleEventToState);
  }

  final LocalizationHelper localizationHelper;

  Future<void> _fetchLocaleFromSharedPrefEventToState(
    FetchLocaleFromSharedPref event,
    Emitter<LocalizationsState> emit,
  ) async {
    try {
      /// Fetch localization from [SharedPreferences]
      final initialLocale = await localizationHelper.locale;

      emit(LocalizationSuccess(locale: initialLocale));
    } catch (e) {
      emit(LocalizationError(errorMessage: e.toString()));
    }
  }

  Future<void> _changeLocaleEventToState(
    ChangeLocale event,
    Emitter<LocalizationsState> emit,
  ) async {
    try {
      /// Store local in [SharedPreferences]
      await localizationHelper.saveLocale(event.locale);
      emit(LocalizationSuccess(locale: event.locale));
    } catch (e) {
      emit(LocalizationError(errorMessage: e.toString()));
    }
  }
}
