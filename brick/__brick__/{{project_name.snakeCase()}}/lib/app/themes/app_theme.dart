import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/app_colors.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/text_styles.dart';

abstract class AppTheme {
  /// Standard `ThemeData` for App UI.
  static ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        textTheme: _textTheme,
      );

  static ThemeData get darkTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
        textTheme: _textTheme,
      );

  static TextTheme get _textTheme => TextTheme(
        headline1: AppTextStyle.headline1,
        headline2: AppTextStyle.headline2,
        headline3: AppTextStyle.headline3,
        headline4: AppTextStyle.headline4,
        headline5: AppTextStyle.headline5,
        headline6: AppTextStyle.headline6,
        subtitle1: AppTextStyle.subtitle1,
        subtitle2: AppTextStyle.subtitle2,
        bodyText1: AppTextStyle.bodyText1,
        bodyText2: AppTextStyle.bodyText2,
        caption: AppTextStyle.caption,
        overline: AppTextStyle.overline,
        button: AppTextStyle.button,
      );

  static const double defaultRadius = 16;
  static final BorderRadius defaultBoardRadius =
      BorderRadius.circular(defaultRadius);
}
