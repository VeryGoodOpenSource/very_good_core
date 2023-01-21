import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:{{project_name.snakeCase()}}/app/config/scroll_behavior.dart';
import 'package:{{project_name.snakeCase()}}/app/constants/constant.dart';
import 'package:{{project_name.snakeCase()}}/app/generated/l10n.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/app_theme.dart';

class MockMaterialApp extends StatelessWidget {
  const MockMaterialApp({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: Constant.appName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        scrollBehavior: ScrollBehaviorConfig(),
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        home: child,
      );
}
