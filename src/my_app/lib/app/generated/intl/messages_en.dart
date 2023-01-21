// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(property) => "${property} is empty";

  static String m1(code, error) => "Error ${code}: ${error}";

  static String m2(author, createdDate) =>
      "Posted by u/${author} ${createdDate}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "common_error_email_format":
            MessageLookupByLibrary.simpleMessage("Invalid email format"),
        "common_error_empty_string": m0,
        "common_error_invalid_password": MessageLookupByLibrary.simpleMessage(
            "Password does not meet the required format"),
        "common_error_max_characters": MessageLookupByLibrary.simpleMessage(
            "Exceeds the number of allowable characters"),
        "common_error_min_characters": MessageLookupByLibrary.simpleMessage(
            "Does not meet the required character length"),
        "common_error_server_error": m1,
        "common_error_unexpected_error":
            MessageLookupByLibrary.simpleMessage("Unexpected Error"),
        "common_generic_error":
            MessageLookupByLibrary.simpleMessage("Oops! Something went wrong"),
        "common_home": MessageLookupByLibrary.simpleMessage("home"),
        "common_no": MessageLookupByLibrary.simpleMessage("no"),
        "common_profile": MessageLookupByLibrary.simpleMessage("profile"),
        "common_yes": MessageLookupByLibrary.simpleMessage("yes"),
        "dialog__message__exit_message": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to close the application?"),
        "login__button_text__login":
            MessageLookupByLibrary.simpleMessage("login"),
        "login__label_text__email":
            MessageLookupByLibrary.simpleMessage("Email"),
        "login__label_text__password":
            MessageLookupByLibrary.simpleMessage("Password"),
        "login__text_field_hint__email":
            MessageLookupByLibrary.simpleMessage("enter email address"),
        "login__text_field_hint__password":
            MessageLookupByLibrary.simpleMessage("enter password"),
        "post__empty_post__empty_post_message":
            MessageLookupByLibrary.simpleMessage("No posts available"),
        "post__post_details__author_and_created_date": m2,
        "post__upvotes_default_value__vote":
            MessageLookupByLibrary.simpleMessage("Vote"),
        "profile__button_text__logout":
            MessageLookupByLibrary.simpleMessage("logout"),
        "profile__header_text__basic_information":
            MessageLookupByLibrary.simpleMessage("Basic Information"),
        "profile__label_text__age": MessageLookupByLibrary.simpleMessage("Age"),
        "profile__label_text__birthday":
            MessageLookupByLibrary.simpleMessage("Birthday"),
        "profile__label_text__email":
            MessageLookupByLibrary.simpleMessage("Email"),
        "profile__label_text__gender":
            MessageLookupByLibrary.simpleMessage("Gender"),
        "profile__label_text__phone_number":
            MessageLookupByLibrary.simpleMessage("Phone Number")
      };
}
