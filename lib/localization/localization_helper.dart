import 'dart:developer';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_tracking_demo/constants/shared_preferences.dart';


const String defaultLocale = 'en';
String currentLocale = defaultLocale;

/// Class for localization
class LocalizationHelper {
  static const String localeLanguageCodeKey = 'localeLanguageCode';
  static const String themeStatusKey = 'themeStatus';

  /// Save locale to [SharedPreferences]
  Future<void> saveLocale(Locale locale) async {
    try {
      await prefs.setString(localeLanguageCodeKey, locale.languageCode);
      currentLocale = locale.languageCode;
    } catch (e) {
      log(e.toString());
    }
  }

  /// Get locale from [SharedPreferences]
  Future<Locale?> get locale async {
    try {
      final languageCode = prefs.getString(localeLanguageCodeKey);

      if (languageCode != null) {
        currentLocale = languageCode;
        return Locale(languageCode);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Clear localization from [SharedPreferences]
  Future<void> clearLocalization() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}
