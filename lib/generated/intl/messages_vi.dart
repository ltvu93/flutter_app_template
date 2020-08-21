// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
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
  String get localeName => 'vi';

  static m0(fieldName) => "${fieldName} không hợp lệ";

  static m1(name) => "Chào ${name}";

  static m2(firstName, lastName) => "Welcome ${lastName} ${firstName}";

  static m3(gender) => "${Intl.gender(gender, female: 'Chào chị!', male: 'Chào anh!', other: 'Chào bạn!')}";

  static m4(role) => "${Intl.select(role, {'admin': 'Chào admin!', 'manager': 'Chào manager!', 'other': 'Chào visitor!', })}";

  static m5(howMany) => "${Intl.plural(howMany, one: '1 tin nhắn', other: '${howMany} tin nhắn')}";

  static m6(fieldName) => "${fieldName} không được bỏ trống";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "formatInvalidValidateError" : m0,
    "pageHomeWelcome" : m1,
    "pageHomeWelcomeFullName" : m2,
    "pageHomeWelcomeGender" : m3,
    "pageHomeWelcomeRole" : m4,
    "pageNotificationsCount" : m5,
    "password" : MessageLookupByLibrary.simpleMessage("Mật khẩu"),
    "passwordValidateError" : MessageLookupByLibrary.simpleMessage("Mật khẩu phải có số lượng ký tự lớn hơn 7 và có ít nhất 1 chữ số"),
    "requiredValidateError" : m6,
    "title" : MessageLookupByLibrary.simpleMessage("Xin Chào")
  };
}
