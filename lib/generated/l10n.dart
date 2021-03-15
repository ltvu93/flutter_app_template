// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null, 'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;
 
      return instance;
    });
  } 

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null, 'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello`
  String get title {
    return Intl.message(
      'Hello',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Welcome {name}`
  String pageHomeWelcome(Object name) {
    return Intl.message(
      'Welcome $name',
      name: 'pageHomeWelcome',
      desc: '',
      args: [name],
    );
  }

  /// `{gender, select, male {Hi man!} female {Hi woman!} other {Hi there!}}`
  String pageHomeWelcomeGender(String gender) {
    return Intl.gender(
      gender,
      male: 'Hi man!',
      female: 'Hi woman!',
      other: 'Hi there!',
      name: 'pageHomeWelcomeGender',
      desc: '',
      args: [gender],
    );
  }

  /// `{role, select, admin {Hi admin!} manager {Hi manager!} other {Hi visitor!}}`
  String pageHomeWelcomeRole(Object role) {
    return Intl.select(
      role,
      {
        'admin': 'Hi admin!',
        'manager': 'Hi manager!',
        'other': 'Hi visitor!',
      },
      name: 'pageHomeWelcomeRole',
      desc: '',
      args: [role],
    );
  }

  /// `{howMany, plural, one{1 message} other{{howMany} messages}}`
  String pageNotificationsCount(num howMany) {
    return Intl.plural(
      howMany,
      one: '1 message',
      other: '$howMany messages',
      name: 'pageNotificationsCount',
      desc: '',
      args: [howMany],
    );
  }

  /// `Welcome {lastName} {firstName}`
  String pageHomeWelcomeFullName(Object firstName, Object lastName) {
    return Intl.message(
      'Welcome $lastName $firstName',
      name: 'pageHomeWelcomeFullName',
      desc: '',
      args: [firstName, lastName],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `{fieldName} is required`
  String requiredValidateError(Object fieldName) {
    return Intl.message(
      '$fieldName is required',
      name: 'requiredValidateError',
      desc: '',
      args: [fieldName],
    );
  }

  /// `{fieldName} format is invalid`
  String formatInvalidValidateError(Object fieldName) {
    return Intl.message(
      '$fieldName format is invalid',
      name: 'formatInvalidValidateError',
      desc: '',
      args: [fieldName],
    );
  }

  /// `The password field must be more than 7 characters and must include at least one number`
  String get passwordValidateError {
    return Intl.message(
      'The password field must be more than 7 characters and must include at least one number',
      name: 'passwordValidateError',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}