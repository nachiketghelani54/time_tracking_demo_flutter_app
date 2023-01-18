import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'localization_delegate.dart';

class ShadeAppLocalization {
  static AppLocalizations get instance =>
      ShadeAppLocalizationsDelegate.instance;
}

extension Localization on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this)!;
}
