import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'localization_delegate.dart';

class TaskAppLocalization {
  static AppLocalizations get instance =>
      TaskAppLocalizationsDelegate.instance;
}

extension Localization on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this)!;
}
