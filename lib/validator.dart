import 'package:flutter_app_template/generated/l10n.dart';

class Validator {
  Validator._();

  static final emailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  static final noneCharacterRegExp = RegExp(r'[^\p{L} ]', unicode: true);
  static final noneCharacterAndNumberRegExp =
      RegExp(r'[^\p{L}0-9 ]', unicode: true);
  static final passwordRegExp = RegExp(r'[^\p{L}0-9 ]', unicode: true);

  static ValidateError textRequired(String value) {
    return value == null || value.isEmpty
        ? ValidateError.required
        : ValidateError.none;
  }

  static ValidateError required(dynamic value, {String errorText}) {
    if (value == null ||
        ((value is Iterable || value is String || value is Map) &&
            value.length == 0)) {
      return ValidateError.required;
    }

    return ValidateError.none;
  }

  static ValidateError textMatches(String value, String otherValue) {
    return value != otherValue ? ValidateError.notMatches : ValidateError.none;
  }

  static ValidateError min(dynamic value, int min) {
    if (value == null ||
        ((value is Iterable || value is String || value is Map) &&
            value.length < min)) {
      return ValidateError.minimum;
    }

    return ValidateError.none;
  }

  static ValidateError max(dynamic value, int max) {
    if (value != null &&
        ((value is Iterable || value is String || value is Map) &&
            value.length > max)) {
      return ValidateError.maximum;
    }

    return ValidateError.none;
  }

  static ValidateError regexMatches(
    String value,
    RegExp regExp, {
    ValidateError error,
  }) {
    return !regExp.hasMatch(value)
        ? error ?? ValidateError.invalidFormat
        : ValidateError.none;
  }

  static ValidateError regexNotMatches(
    String value,
    RegExp regExp, {
    ValidateError error,
  }) {
    return regExp.hasMatch(value)
        ? error ?? ValidateError.invalidFormat
        : ValidateError.none;
  }

  static ValidateError getError(List<ValidateError> errors) {
    return errors.firstWhere(
      (error) => error != ValidateError.none,
      orElse: () => ValidateError.none,
    );
  }

  static ValidateError name(String name) {
    return getError([
      textRequired(name),
      max(name, 30),
      regexNotMatches(
        name,
        noneCharacterAndNumberRegExp,
        error: ValidateError.noSpecialCharactersOrNumbersAllow,
      ),
    ]);
  }

  static ValidateError email(String email) {
    return getError([
      textRequired(email),
      regexMatches(email, emailRegExp),
    ]);
  }

  static ValidateError phone(String phone) {
    ValidateError phoneError = ValidateError.none;
    final rawPhoneNumber = phone.replaceAll(RegExp('[+ #*-.]'), '');
    if (phone.contains(RegExp('[^0-9 ]'))) {
      phoneError = ValidateError.invalidFormat;
    }
    if (phone.startsWith('84')) {
      if (rawPhoneNumber.length != 11) {
        phoneError = ValidateError.invalidFormat;
      }
    } else {
      if (rawPhoneNumber.length != 10) {
        phoneError = ValidateError.invalidFormat;
      }
    }

    return getError([
      textRequired(phone),
      phoneError,
    ]);
  }

  static ValidateError password(String password) {
    return getError([
      textRequired(password),
      min(password, 7),
    ]);
  }

  static ValidateError confirmPassword(
    String confirmPassword,
    String password,
  ) {
    return getError([
      Validator.password(confirmPassword),
      textMatches(confirmPassword, password),
    ]);
  }
}

enum ValidateError {
  none,
  required,
  notMatches,
  minimum,
  maximum,
  invalidFormat,
  noSpecialCharactersOrNumbersAllow,
  noSpecialCharactersAllow,
  password,
}

extension ValidateErrorExtension on ValidateError {
  bool get isNone => this == ValidateError.none;

  String getMessage(
    S appLocalizations,
    String fieldName, {
    int minMaxValue,
  }) {
    switch (this) {
      case ValidateError.none:
        return null;
      case ValidateError.required:
        return appLocalizations.requiredValidateError(fieldName);
      case ValidateError.notMatches:
        return '';
      case ValidateError.minimum:
        return '';
      case ValidateError.maximum:
        return '';
      case ValidateError.invalidFormat:
        return appLocalizations.formatInvalidValidateError(fieldName);
      case ValidateError.noSpecialCharactersOrNumbersAllow:
        return '';
      case ValidateError.noSpecialCharactersAllow:
        return '';
      case ValidateError.password:
        return appLocalizations.passwordValidateError;
      default:
        throw Exception("Don't support this type $this");
    }
  }
}
