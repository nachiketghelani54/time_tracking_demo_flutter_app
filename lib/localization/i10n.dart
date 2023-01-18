import 'package:flutter/material.dart';

import 'localization.dart';

class L10n {
  const L10n._(this.value);

  static const enUS = L10n._('en_US');
  static const de = L10n._('de');

  final String value;

  static final all = [
    const Locale('en', 'US'),
    const Locale('de'),
  ];

  // static final all = [
  //   const Locale('en'),
  //   const Locale('he'),
  // ];

  static List<L10n> get values => [
        enUS,
        de,
      ];

  Locale getLocale() {
    if (this == de) {
      return const Locale('de');
    } else {
      return const Locale('en', 'US');
    }
  }

  @override
  String toString() {
    switch (this) {
      case enUS:
        return ShadeAppLocalization.instance.english;
      case de:
        return ShadeAppLocalization.instance.german;
      default:
        return '';
    }
  }

  String toUiLocales() {
    switch (this) {
      case enUS:
        return 'en-US';
      case de:
        return 'de';
      default:
        return '';
    }
  }

  static L10n get(String value) => values.firstWhere(
        (it) => it.value.toLowerCase().startsWith(value.toLowerCase()),
        orElse: () => values.first,
      );
}
