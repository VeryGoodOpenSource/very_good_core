import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_core/app/app.dart';
import 'package:very_good_core/counter/counter.dart';

import '../../helpers/helpers.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });

    group('renders the correct color scheme', () {
      testWidgets('on ambient mode updates', (tester) async {
        await tester.pumpWidget(const App());

        MaterialApp getMaterialApp() {
          return find.byType(MaterialApp).evaluate().first.widget
              as MaterialApp;
        }

        expect(
          getMaterialApp().theme?.colorScheme,
          const ColorScheme.dark(
            primary: Color(0xFF00B5FF),
          ),
        );

        await simulatePlatformCall('wear', 'onUpdateAmbient');
        await tester.pumpAndSettle();

        expect(
          getMaterialApp().theme?.colorScheme,
          const ColorScheme.dark(
            primary: Colors.white24,
            onBackground: Colors.white10,
            onSurface: Colors.white10,
          ),
        );

        await simulatePlatformCall('wear', 'onExitAmbient');
        await tester.pumpAndSettle();

        expect(
          getMaterialApp().theme?.colorScheme,
          const ColorScheme.dark(
            primary: Color(0xFF00B5FF),
          ),
        );
      });
    });
  });
}
