import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_core/l10n/l10n.dart';

extension PumpRoute on WidgetTester {
  Future<void> pumpRoute(Route<dynamic> route) {
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Navigator(onGenerateInitialRoutes: (_, __) => [route]),
      ),
    );
  }
}
