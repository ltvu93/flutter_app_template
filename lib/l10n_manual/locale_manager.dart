import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleManager extends ChangeNotifier {
  static final String _languageCodeKey = 'languageCode';

  Locale locale;

  LocaleManager() {
    _loadLocale();
  }

  void _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();

    final languageCode = prefs.getString(_languageCodeKey) ?? '';

    if (languageCode.isNotEmpty) {
      locale = Locale(languageCode);
    } else {
      locale = Locale('en');
    }
    notifyListeners();
  }

  void updateLocale(Locale newLocale) async {
    final prefs = await SharedPreferences.getInstance();

    final result =
        await prefs.setString(_languageCodeKey, newLocale.languageCode);

    if (result) {
      locale = newLocale;
      notifyListeners();
    }
  }
}
