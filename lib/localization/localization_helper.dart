import 'dart:developer';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../constants/shared_preference.dart';

const String defaultLocale = 'en';
const bool defaultTheme = false;
String currentLocale = defaultLocale;
bool themeValue = defaultTheme;

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
  /// Save theme to [SharedPreferences]
  Future<void> saveTheme(bool themeStatus) async {
    try {
      await prefs.setBool(themeStatusKey, themeStatus);
      themeValue = themeStatus;
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
  /// Get theme from [SharedPreferences]
  Future<bool> get theme async {
    try {
      final themeStatus = prefs.getBool(themeStatusKey);

      if (themeStatus != null) {
        themeValue = themeStatus;
        return themeStatus;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Clear localization from [SharedPreferences]
  Future<void> clearLocalization() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
  /// Clear theme from [SharedPreferences]
  Future<void> clearTheme() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}
