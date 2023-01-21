import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:very_good_core/app/config/scroll_behavior.dart';
import 'package:very_good_core/app/constants/constant.dart';
import 'package:very_good_core/app/generated/l10n.dart';
import 'package:very_good_core/app/routes/app_router.dart';
import 'package:very_good_core/app/themes/app_theme.dart';
import 'package:very_good_core/app/utils/injection.dart';
import 'package:very_good_core/core/domain/bloc/very_good_core/very_good_core_bloc.dart';

class App extends StatelessWidget {
  App({super.key});

  final GoRouter routerConfig =
      getIt<AppRouter>(param1: getIt<VeryGoodCoreBloc>()).router;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<VeryGoodCoreBloc>(
            create: (BuildContext context) => getIt<VeryGoodCoreBloc>(),
          ),
        ],
        child: BlocBuilder<VeryGoodCoreBloc, VeryGoodCoreState>(
          builder: (BuildContext context, VeryGoodCoreState state) =>
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
