import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShadeAppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const ShadeAppLocalizationsDelegate();

  static late AppLocalizations instance;

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.delegate.isSupported(locale);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final instanceLocale = await AppLocalizations.delegate.load(locale);
    ShadeAppLocalizationsDelegate.instance = instanceLocale;
    return instance;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
