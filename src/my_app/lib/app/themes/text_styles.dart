import 'package:flutter/widgets.dart';

/// App Text Style Definitions
abstract class AppTextStyle {
  static const TextStyle _baseTextStyle = TextStyle(
    //fontFamily: Assets.fonts.openSansRegular,
    fontWeight: AppFontWeight.regular,
  );

  /// Headline 1 Text Style
  static TextStyle get displayLarge => _baseTextStyle.copyWith(
        fontSize: 56,
        fontWeight: AppFontWeight.medium,
      );

  /// Headline 2 Text Style
  static TextStyle get displayMedium => _baseTextStyle.copyWith(
        fontSize: 30,
        fontWeight: AppFontWeight.regular,
      );

  /// Headline 3 Text Style
  static TextStyle get displaySmall => _baseTextStyle.copyWith(
        fontSize: 28,
        fontWeight: AppFontWeight.regular,
      );

  /// Headline 4 Text Style
  static TextStyle get headlineMedium => _baseTextStyle.copyWith(
        fontSize: 22,
        fontWeight: AppFontWeight.bold,
      );

  /// Headline 5 Text Style
  static TextStyle get headlineSmall => _baseTextStyle.copyWith(
        fontSize: 20,
        fontWeight: AppFontWeight.medium,
      );

  /// Headline 6 Text Style
  static TextStyle get titleLarge => _baseTextStyle.copyWith(
        fontSize: 22,
        fontWeight: AppFontWeight.bold,
      );

  /// Subtitle 1 Text Style
  static TextStyle get titleMedium => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: AppFontWeight.bold,
      );

  /// Subtitle 2 Text Style
  static TextStyle get titleSmall => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: AppFontWeight.bold,
      );

  /// Body Text 1 Text Style
  static TextStyle get bodyLarge => _baseTextStyle.copyWith(
        fontSize: 18,
        fontWeight: AppFontWeight.medium,
      );

  /// Body Text 2 Text Style (the default)
  static TextStyle get bodyMedium => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: AppFontWeight.regular,
      );

  /// bodySmall Text Style
  static TextStyle get bodySmall => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: AppFontWeight.regular,
      );

  /// labelSmall Text Style
  static TextStyle get labelSmall => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: AppFontWeight.regular,
      );

  /// labelLarge Text Style
  static TextStyle get labelLarge => _baseTextStyle.copyWith(
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
