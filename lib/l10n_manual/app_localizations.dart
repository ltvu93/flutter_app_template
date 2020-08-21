import 'package:flutter/material.dart';
import 'package:flutter_app_template/l10n_manual/data/en.dart';
import 'package:flutter_app_template/l10n_manual/data/vi.dart';

class AppLocalizations {
  final Locale locale;

  static Map<String, String> _localizedValues;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = AppLocalizations(locale);

//    String jsonContent = await rootBundle.loadString(
//      "locale/i18n_${locale.languageCode}.json",
//    );
//    _localizedValues = json.decode(jsonContent);

    switch (locale.languageCode) {
      case 'vi':
        _localizedValues = vi;
        break;
      default:
        _localizedValues = en;
        break;
    }

    print('$locale $_localizedValues');

    return appLocalizations;
  }

  String translate(String key) {
    final value = _localizedValues[key];

    if (value != null) {
      return value;
    } else {
      throw Exception('Not found the text value with "$key" key');
    }
  }
}

// Localizations depend on device setting language
class DeviceLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const DeviceLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
//    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(DeviceLocalizationsDelegate old) => false;
}

// Localizations depend on app setting language
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  final Locale appLocale;

  AppLocalizationsDelegate(Locale locale) : appLocale = locale ?? Locale('en');

  @override
  bool isSupported(Locale locale) => appLocale != null;

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(appLocale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => true;
}
