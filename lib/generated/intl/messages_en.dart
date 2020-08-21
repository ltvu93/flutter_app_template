// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(fieldName) => "${fieldName} format is invalid";

  static m1(name) => "Welcome ${name}";

  static m2(firstName, lastName) => "Welcome ${lastName} ${firstName}";

  static m3(gender) => "${Intl.gender(gender, female: 'Hi woman!', male: 'Hi man!', other: 'Hi there!')}";

  static m4(role) => "${Intl.select(role, {'admin': 'Hi admin!', 'manager': 'Hi manager!', 'other': 'Hi visitor!', })}";

  static m5(howMany) => "${Intl.plural(howMany, one: '1 message', other: '${howMany} messages')}";

  static m6(fieldName) => "${fieldName} is required";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "formatInvalidValidateError" : m0,
    "pageHomeWelcome" : m1,
    "pageHomeWelcomeFullName" : m2,
    "pageHomeWelcomeGender" : m3,
    "pageHomeWelcomeRole" : m4,
    "pageNotificationsCount" : m5,
    "password" : MessageLookupByLibrary.simpleMessage("Password"),
    "passwordValidateError" : MessageLookupByLibrary.simpleMessage("The password field must be more than 7 characters and must include at least one number"),
    "requiredValidateError" : m6,
    "title" : MessageLookupByLibrary.simpleMessage("Hello")
  };
}
