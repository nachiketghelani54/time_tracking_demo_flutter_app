part of 'theme_bloc.dart';

/// All events of Theme
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

/// Event when user tries to change Theme
class ThemeChanged extends ThemeEvent {
  const ThemeChanged({required this.theme, required this.status});

  final ThemeData theme;
  final bool status;

  @override
  List<Object> get props => [theme, status];
}

class FetchThemeFromSharedPref extends ThemeEvent {
  const FetchThemeFromSharedPref();

  @override
  List<Object> get props => [];
}
