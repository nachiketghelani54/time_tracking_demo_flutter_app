part of 'localization_bloc.dart';

/// All events of Localization
abstract class LocalizationsEvent extends Equatable {
  const LocalizationsEvent();

  @override
  List<Object?> get props => [];
}

/// Event when user tries to change localization
class ChangeLocale extends LocalizationsEvent {
  const ChangeLocale(this.locale);

  final Locale locale;

  @override
  List<Object> get props => [locale];
}

///Fetch localization
class FetchLocaleFromSharedPref extends LocalizationsEvent {
  const FetchLocaleFromSharedPref();

  @override
  List<Object> get props => [];
}
