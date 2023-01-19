import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'bottom_nav_event.dart';

part 'bottom_nav_state.dart';

/// Localization BLoC Class for listen events of Localization
class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc()
      : super( LoadingState(0)) {
    on<ChangeTab>(_changeLocaleEventToState);
  }

  Future<void> _changeLocaleEventToState(
    ChangeTab event,
    Emitter<BottomNavState> emit,
  ) async {
    try {
      /// Store local in [SharedPreferences]
      emit(BottomNavSuccess(locale: event.selectedTab));
    } catch (e) {
      emit(BottomNavError(errorMessage: e.toString()));
    }
  }
}
