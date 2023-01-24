import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_tracking_demo/constants/shared_preferences.dart';

const bool defaultTheme = false;
bool themeValue = defaultTheme;

/// Class for localization
class ThemeHelper {
  static const String themeStatusKey = 'themeStatus';

  /// Save theme to [SharedPreferences]
  Future<void> saveTheme(bool themeStatus) async {
    try {
      await prefs.setBool(themeStatusKey, themeStatus);
      themeValue = themeStatus;
    } catch (e) {
      log(e.toString());
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

  /// Clear theme from [SharedPreferences]
  Future<void> clearTheme() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}
