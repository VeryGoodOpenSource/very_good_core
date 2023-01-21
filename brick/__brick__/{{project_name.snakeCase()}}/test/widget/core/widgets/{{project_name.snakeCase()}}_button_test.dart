import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}/core/presentation/widgets/{{project_name.snakeCase()}}_button.dart';

import '../../../utils/test_utils.dart';

void main() {
  group('{{#pascalCase}}{{project_name}}{{/pascalCase}}Button Widget Tests', () {
    int counter = 0;

    GoldenTestGroup buildButtonTestGroup() => GoldenTestGroup(
          children: <Widget>[
            GoldenTestScenario(
              name: 'default',
              child: {{#pascalCase}}{{project_name}}{{/pascalCase}}Button(
                text: 'Button',
                onPressed: () => counter++,
              ),
            ),
            GoldenTestScenario(
              name: 'isExpanded',
              constraints: const BoxConstraints(minWidth: 200),
              child: {{#pascalCase}}{{project_name}}{{/pascalCase}}Button(
                text: 'Button',
                isExpanded: true,
                onPressed: () => counter++,
              ),
            ),
            GoldenTestScenario(
              name: 'isDisabled',
              child: {{#pascalCase}}{{project_name}}{{/pascalCase}}Button(
                text: 'Button',
                isEnabled: false,
                onPressed: () => counter++,
              ),
            ),
            GoldenTestScenario(
              name: 'isDisabled & isExpanded',
              constraints: const BoxConstraints(minWidth: 200),
              child: {{#pascalCase}}{{project_name}}{{/pascalCase}}Button(
                text: 'Button',
                isExpanded: true,
                isEnabled: false,
                onPressed: () => counter++,
              ),
            ),
          ],
        );

    goldenTest(
      'renders correctly in initial state',
      fileName: '{{project_name.snakeCase()}}_button'.goldensVersion,
      builder: buildButtonTestGroup,
      pumpBeforeTest: (WidgetTester tester) async {
        await tester.pump(const Duration(seconds: 1));
      },
    );
  });
}
