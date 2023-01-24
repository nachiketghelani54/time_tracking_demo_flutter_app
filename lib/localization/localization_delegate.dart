import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskAppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const TaskAppLocalizationsDelegate();

  static late AppLocalizations instance;

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.delegate.isSupported(locale);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final instanceLocale = await AppLocalizations.delegate.load(locale);
    TaskAppLocalizationsDelegate.instance = instanceLocale;
    return instance;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
