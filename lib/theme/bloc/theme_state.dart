part of 'theme_bloc.dart';

/// State when user tries to change theme
abstract class ThemeState extends Equatable {
  const ThemeState(this.appTheme, this.status);

  final ThemeData? appTheme;
  final bool? status;

  @override
  List<Object?> get props => [appTheme, status];
}

/// LoadingState
class LoadingState extends ThemeState {
  const LoadingState() : super(null, null);

  @override
  List<Object> get props => [];
}

/// ThemeSuccess
class ThemeSuccess extends ThemeState {
  const ThemeSuccess({ThemeData? appTheme, bool? status})
      : super(appTheme, status);

  @override
  List<Object?> get props => [appTheme, status];
}
