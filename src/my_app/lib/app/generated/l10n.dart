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
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Invalid email format`
  String get common_error_email_format {
    return Intl.message(
      'Invalid email format',
      name: 'common_error_email_format',
      desc: '',
      args: [],
    );
  }

  /// `{property} is empty`
  String common_error_empty_string(Object property) {
    return Intl.message(
      '$property is empty',
      name: 'common_error_empty_string',
      desc: '',
      args: [property],
    );
  }

  /// `Password does not meet the required format`
  String get common_error_invalid_password {
    return Intl.message(
      'Password does not meet the required format',
      name: 'common_error_invalid_password',
      desc: '',
      args: [],
    );
  }

  /// `Exceeds the number of allowable characters`
  String get common_error_max_characters {
    return Intl.message(
      'Exceeds the number of allowable characters',
      name: 'common_error_max_characters',
      desc: '',
      args: [],
    );
  }

  /// `Does not meet the required character length`
  String get common_error_min_characters {
    return Intl.message(
      'Does not meet the required character length',
      name: 'common_error_min_characters',
      desc: '',
      args: [],
    );
  }

  /// `Error {code}: {error}`
  String common_error_server_error(Object code, Object error) {
    return Intl.message(
      'Error $code: $error',
      name: 'common_error_server_error',
      desc: '',
      args: [code, error],
    );
  }

  /// `Unexpected Error`
  String get common_error_unexpected_error {
    return Intl.message(
      'Unexpected Error',
      name: 'common_error_unexpected_error',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong`
  String get common_generic_error {
    return Intl.message(
      'Oops! Something went wrong',
      name: 'common_generic_error',
      desc: '',
      args: [],
    );
  }

  /// `home`
  String get common_home {
    return Intl.message(
      'home',
      name: 'common_home',
      desc: '',
      args: [],
    );
  }

  /// `no`
  String get common_no {
    return Intl.message(
      'no',
      name: 'common_no',
      desc: '',
      args: [],
    );
  }

  /// `profile`
  String get common_profile {
    return Intl.message(
      'profile',
      name: 'common_profile',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get common_yes {
    return Intl.message(
      'yes',
      name: 'common_yes',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to close the application?`
  String get dialog__message__exit_message {
    return Intl.message(
      'Are you sure you want to close the application?',
      name: 'dialog__message__exit_message',
      desc: '',
      args: [],
    );
  }

  /// `login`
  String get login__button_text__login {
    return Intl.message(
      'login',
      name: 'login__button_text__login',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get login__label_text__email {
    return Intl.message(
      'Email',
      name: 'login__label_text__email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get login__label_text__password {
    return Intl.message(
      'Password',
      name: 'login__label_text__password',
      desc: '',
      args: [],
    );
  }

  /// `enter email address`
  String get login__text_field_hint__email {
    return Intl.message(
      'enter email address',
      name: 'login__text_field_hint__email',
      desc: '',
      args: [],
    );
  }

  /// `enter password`
  String get login__text_field_hint__password {
    return Intl.message(
      'enter password',
      name: 'login__text_field_hint__password',
      desc: '',
      args: [],
    );
  }

  /// `No posts available`
  String get post__empty_post__empty_post_message {
    return Intl.message(
      'No posts available',
      name: 'post__empty_post__empty_post_message',
      desc: '',
      args: [],
    );
  }

  /// `Posted by u/{author} {createdDate}`
  String post__post_details__author_and_created_date(
      Object author, Object createdDate) {
    return Intl.message(
      'Posted by u/$author $createdDate',
      name: 'post__post_details__author_and_created_date',
      desc: '',
      args: [author, createdDate],
    );
  }

  /// `Vote`
  String get post__upvotes_default_value__vote {
    return Intl.message(
      'Vote',
      name: 'post__upvotes_default_value__vote',
      desc: '',
      args: [],
    );
  }

  /// `logout`
  String get profile__button_text__logout {
    return Intl.message(
      'logout',
      name: 'profile__button_text__logout',
      desc: '',
      args: [],
    );
  }

  /// `Basic Information`
  String get profile__header_text__basic_information {
    return Intl.message(
      'Basic Information',
      name: 'profile__header_text__basic_information',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get profile__label_text__age {
    return Intl.message(
      'Age',
      name: 'profile__label_text__age',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get profile__label_text__birthday {
    return Intl.message(
      'Birthday',
      name: 'profile__label_text__birthday',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get profile__label_text__email {
    return Intl.message(
      'Email',
      name: 'profile__label_text__email',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get profile__label_text__gender {
    return Intl.message(
      'Gender',
      name: 'profile__label_text__gender',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get profile__label_text__phone_number {
    return Intl.message(
      'Phone Number',
      name: 'profile__label_text__phone_number',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
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
