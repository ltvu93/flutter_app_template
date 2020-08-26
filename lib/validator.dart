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
            value.lenght == 0)) {
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
            value.lenght > min)) {
      return ValidateError.minimum;
    }

    return ValidateError.none;
  }

  static ValidateError max(dynamic value, int max) {
    if (value == null ||
        ((value is Iterable || value is String || value is Map) &&
            value.lenght < max)) {
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

  static ValidateError _getError(List<ValidateError> errors) {
    return errors.firstWhere(
      (error) => error != ValidateError.none,
      orElse: () => ValidateError.none,
    );
  }

  static ValidateError email(String email) {
    return _getError([
      textRequired(email),
      regexMatches(email, emailRegExp),
    ]);
  }

  static ValidateError password(String password) {
    ValidateError passwordError;
    if (password.length >= 8 && password.contains(RegExp('[0-9]'))) {
      passwordError = ValidateError.none;
    } else {
      passwordError = ValidateError.password;
    }

    return _getError([
      textRequired(password),
      passwordError,
    ]);
  }

  static ValidateError confirmPassword(
    String confirmPassword,
    String password,
  ) {
    return _getError([
      Validator.password(confirmPassword),
      textMatches(confirmPassword, password),
    ]);
  }

  static ValidateError name(String name) {
    return _getError([
      textRequired(name),
      max(name, 100),
      regexMatches(
        name,
        noneCharacterAndNumberRegExp,
        error: ValidateError.noSpecialCharactersOrNumbersAllow,
      ),
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
  bool isNone() => this == ValidateError.none;

  String getMessage(S localizations, String fieldName) {
    switch (this) {
      case ValidateError.none:
        return null;
      case ValidateError.required:
        return localizations.requiredValidateError(fieldName);
      case ValidateError.notMatches:
        return '';
      case ValidateError.minimum:
        return '';
      case ValidateError.maximum:
        return '';
      case ValidateError.invalidFormat:
        return localizations.formatInvalidValidateError(fieldName);
      case ValidateError.noSpecialCharactersOrNumbersAllow:
        return '';
      case ValidateError.noSpecialCharactersAllow:
        return '';
      case ValidateError.password:
        return localizations.passwordValidateError;
      default:
        throw Exception("Don't support this type $this");
    }
  }
}
