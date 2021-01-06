import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleManager extends ChangeNotifier {
  static const String _languageCodeKey = 'languageCode';

  Locale locale;

  LocaleManager() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();

    final languageCode = prefs.getString(_languageCodeKey) ?? '';

    if (languageCode.isNotEmpty) {
      locale = Locale(languageCode);
    } else {
      locale = const Locale('en');
    }
    notifyListeners();
  }

  Future<void> updateLocale(Locale newLocale) async {
    final prefs = await SharedPreferences.getInstance();

    final result =
        await prefs.setString(_languageCodeKey, newLocale.languageCode);

    if (result) {
      locale = newLocale;
      notifyListeners();
    }
  }
}
