import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}/core/presentation/screens/loading_screen.dart';

import '../../../utils/golden_test_device_scenario.dart';
import '../../../utils/mock_material_app.dart';
import '../../../utils/test_utils.dart';

void main() {
  Widget buildLoadingScreen() => MockMaterialApp(
        child: LoadingScreen.scaffold(),
      );

  group('Loading Screen Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'loading_screen'.goldensVersion,
      pumpBeforeTest: (WidgetTester tester) async {
        await tester.pump(const Duration(seconds: 1));
      },
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestDeviceScenario(
            name: 'default',
            builder: buildLoadingScreen,
          ),
        ],
      ),
    );
  });
}
