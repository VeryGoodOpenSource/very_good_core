import 'package:flutter/widgets.dart';

/// App Text Style Definitions
abstract class AppTextStyle {
  static const TextStyle _baseTextStyle = TextStyle(
    //fontFamily: Assets.fonts.openSansRegular,
    fontWeight: AppFontWeight.regular,
  );

  /// Headline 1 Text Style
  static TextStyle get headline1 => _baseTextStyle.copyWith(
        fontSize: 56,
        fontWeight: AppFontWeight.medium,
      );

  /// Headline 2 Text Style
  static TextStyle get headline2 => _baseTextStyle.copyWith(
        fontSize: 30,
        fontWeight: AppFontWeight.regular,
      );

  /// Headline 3 Text Style
  static TextStyle get headline3 => _baseTextStyle.copyWith(
        fontSize: 28,
        fontWeight: AppFontWeight.regular,
      );

  /// Headline 4 Text Style
  static TextStyle get headline4 => _baseTextStyle.copyWith(
        fontSize: 22,
        fontWeight: AppFontWeight.bold,
      );

  /// Headline 5 Text Style
  static TextStyle get headline5 => _baseTextStyle.copyWith(
        fontSize: 20,
        fontWeight: AppFontWeight.medium,
      );

  /// Headline 6 Text Style
  static TextStyle get headline6 => _baseTextStyle.copyWith(
        fontSize: 22,
        fontWeight: AppFontWeight.bold,
      );

  /// Subtitle 1 Text Style
  static TextStyle get subtitle1 => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: AppFontWeight.bold,
      );

  /// Subtitle 2 Text Style
  static TextStyle get subtitle2 => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: AppFontWeight.bold,
      );

  /// Body Text 1 Text Style
  static TextStyle get bodyText1 => _baseTextStyle.copyWith(
        fontSize: 18,
        fontWeight: AppFontWeight.medium,
      );

  /// Body Text 2 Text Style (the default)
  static TextStyle get bodyText2 => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: AppFontWeight.regular,
      );

  /// Caption Text Style
  static TextStyle get caption => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: AppFontWeight.regular,
      );

  /// Overline Text Style
  static TextStyle get overline => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: AppFontWeight.regular,
      );

  /// Button Text Style
  static TextStyle get button => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: AppFontWeight.medium,
      );
}

abstract class AppFontWeight {
  /// FontWeight value of `w900`
  static const FontWeight black = FontWeight.w900;

  /// FontWeight value of `w800`
  static const FontWeight extraBold = FontWeight.w800;

  /// FontWeight value of `w700`
  static const FontWeight bold = FontWeight.w700;

  /// FontWeight value of `w600`
  static const FontWeight semiBold = FontWeight.w600;

  /// FontWeight value of `w500`
  static const FontWeight medium = FontWeight.w500;

  /// FontWeight value of `w400`
  static const FontWeight regular = FontWeight.w400;

  /// FontWeight value of `w300`
  static const FontWeight light = FontWeight.w300;

  /// FontWeight value of `w200`
  static const FontWeight extraLight = FontWeight.w200;

  /// FontWeight value of `w100`
  static const FontWeight thin = FontWeight.w100;
}
