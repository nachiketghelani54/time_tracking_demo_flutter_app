part of 'localization_bloc.dart';

/// State when user tries to change localization
abstract class LocalizationsState extends Equatable {
  const LocalizationsState(this.locale);

  final Locale? locale;

  @override
  List<Object?> get props => [locale];
}

class LoadingState extends LocalizationsState {
  const LoadingState() : super(null);

  @override
  List<Object> get props => [];
}

class LocalizationSuccess extends LocalizationsState {
  const LocalizationSuccess({Locale? locale}) : super(locale);

  @override
  List<Object?> get props => [locale];
}

class LocalizationError extends LocalizationsState {
  const LocalizationError({this.errorMessage}) : super(null);

  final String? errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
