import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_core/core/presentation/screens/error_screen.dart';

import '../../../utils/golden_test_device_scenario.dart';
import '../../../utils/mock_material_app.dart';
import '../../../utils/test_utils.dart';

void main() {
  Widget buildErrorScreen() => const MockMaterialApp(
        child: Scaffold(
          body: ErrorScreen(onRefresh: null, errorMessage: 'Unexpected error'),
        ),
      );

  group('Error Screen Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'error_screen'.goldensVersion,
      pumpBeforeTest: (WidgetTester tester) async {
        await tester.pump(const Duration(seconds: 1));
      },
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestDeviceScenario(
            name: 'default',
            builder: buildErrorScreen,
          ),
        ],
      ),
    );
  });
}
