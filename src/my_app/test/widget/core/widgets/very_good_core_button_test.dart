import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_core/core/presentation/widgets/very_good_core_button.dart';

import '../../../utils/test_utils.dart';

void main() {
  group('VeryGoodCoreButton Widget Tests', () {
    int counter = 0;

    GoldenTestGroup buildButtonTestGroup() => GoldenTestGroup(
          children: <Widget>[
            GoldenTestScenario(
              name: 'default',
              child: VeryGoodCoreButton(
                text: 'Button',
                onPressed: () => counter++,
              ),
            ),
            GoldenTestScenario(
              name: 'isExpanded',
              constraints: const BoxConstraints(minWidth: 200),
              child: VeryGoodCoreButton(
                text: 'Button',
                isExpanded: true,
                onPressed: () => counter++,
              ),
            ),
            GoldenTestScenario(
              name: 'isDisabled',
              child: VeryGoodCoreButton(
                text: 'Button',
                isEnabled: false,
                onPressed: () => counter++,
              ),
            ),
            GoldenTestScenario(
              name: 'isDisabled & isExpanded',
              constraints: const BoxConstraints(minWidth: 200),
              child: VeryGoodCoreButton(
                text: 'Button',
                isEnabled: false,
                isExpanded: true,
                onPressed: () => counter++,
              ),
            ),
          ],
        );

    goldenTest(
      'renders correctly in initial state',
      fileName: 'very_good_core_button'.goldensVersion,
      pumpBeforeTest: (WidgetTester tester) async {
        await tester.pump(const Duration(seconds: 1));
      },
      builder: buildButtonTestGroup,
    );
  });
}
