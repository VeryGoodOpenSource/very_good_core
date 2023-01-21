import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:{{project_name.snakeCase()}}/app/config/scroll_behavior.dart';
import 'package:{{project_name.snakeCase()}}/app/constants/constant.dart';
import 'package:{{project_name.snakeCase()}}/app/generated/l10n.dart';
import 'package:{{project_name.snakeCase()}}/app/routes/app_router.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/app_theme.dart';
import 'package:{{project_name.snakeCase()}}/app/utils/injection.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/bloc/{{project_name.snakeCase()}}/{{project_name.snakeCase()}}_bloc.dart';

class App extends StatelessWidget {
  App({super.key});

  final GoRouter routerConfig =
      getIt<AppRouter>(param1: getIt<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc>()).router;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc>(
            create: (BuildContext context) => getIt<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc>(),
          ),
        ],
        child: BlocBuilder<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc, {{#pascalCase}}{{project_name}}{{/pascalCase}}State>(
          builder: (BuildContext context, {{#pascalCase}}{{project_name}}{{/pascalCase}}State state) =>
              MaterialApp.router(
            title: Constant.appName,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            debugShowCheckedModeBanner: false,
            scrollBehavior: ScrollBehaviorConfig(),
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.delegate.supportedLocales,
            builder: (BuildContext context, Widget? widget) =>
                ResponsiveWrapper.builder(
              widget,
              minWidth: Constant.mobileBreakpoint,
              breakpoints: const <ResponsiveBreakpoint>[
                ResponsiveBreakpoint.autoScaleDown(
                  Constant.mobileBreakpoint,
                  name: PHONE,
                ),
                ResponsiveBreakpoint.resize(
                  Constant.mobileBreakpoint,
                  name: MOBILE,
                ),
                ResponsiveBreakpoint.resize(
                  Constant.tabletBreakpoint,
                  name: TABLET,
                ),
                ResponsiveBreakpoint.resize(
                  Constant.desktopBreakpoint,
                  name: DESKTOP,
                ),
              ],
            ),
            routerConfig: routerConfig,
          ),
        ),
      );
}
