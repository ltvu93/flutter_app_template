import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/domain/locale_manager.dart';
import 'package:flutter_app_template/generated/l10n.dart';
import 'package:provider/provider.dart';

class ChangeLanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<LocaleManager>(
            builder: (_, localManager, __) {
              return Column(
                children: [
                  Text(
                    S.of(context).title,
                  ),
                  Text(
                    S.of(context).pageHomeWelcome('John'),
                  ),
                  Text(S.of(context).pageHomeWelcomeGender("male")),
                  Text(S.of(context).pageHomeWelcomeRole("admin")),
                  Text(S.of(context).pageNotificationsCount(1)),
                  Text(S.of(context).pageNotificationsCount(2)),
                  Text(S.of(context).pageHomeWelcomeFullName("John", "Doe")),
                  for (Locale locale in S.delegate.supportedLocales)
                    ListTile(
                      leading: Radio<Locale>(
                        value: locale,
                        groupValue: localManager.locale,
                        onChanged: (Locale value) {
                          localManager.updateLocale(value);
                        },
                      ),
                      title: Text(locale.languageCode),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
