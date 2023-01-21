import 'package:alchemist/alchemist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}/core/presentation/widgets/{{project_name.snakeCase()}}_text_field.dart';

import '../../../utils/test_utils.dart';

void main() {
  late TextEditingController controller;
  late FocusNode focusNode;

  setUp(() {
    controller = TextEditingController();
    focusNode = FocusNode();
  });

  tearDown(() {
    controller.dispose();
    focusNode.dispose();
  });

  group('{{#pascalCase}}{{project_name}}{{/pascalCase}}TextField Widget Tests', () {
    GoldenTestGroup buildTextFieldTestGroup({bool isPassword = false}) =>
        GoldenTestGroup(
          children: <Widget>[
            GoldenTestScenario(
              name: 'default',
              constraints: const BoxConstraints(minWidth: 200),
              child: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextField(
                controller: controller,
                labelText: 'Label',
                isPassword: isPassword,
              ),
            ),
            GoldenTestScenario(
              name: 'is focused w/ hint',
              constraints: const BoxConstraints(minWidth: 200),
              child: Builder(
                builder: (BuildContext context) {
                  focusNode.requestFocus();

                  return {{#pascalCase}}{{project_name}}{{/pascalCase}}TextField(
                    controller: controller,
                    labelText: 'Label',
                    hintText: 'hint',
                    autofocus: true,
                    focusNode: focusNode,
                    isPassword: isPassword,
                  );
                },
              ),
            ),
            GoldenTestScenario(
              name: 'is focused w/o hint',
              constraints: const BoxConstraints(minWidth: 200),
              child: Builder(
                builder: (BuildContext context) {
                  focusNode.requestFocus();

                  return {{#pascalCase}}{{project_name}}{{/pascalCase}}TextField(
                    controller: controller,
                    labelText: 'Label',
                    autofocus: true,
                    focusNode: focusNode,
                    isPassword: isPassword,
                  );
                },
              ),
            ),
            GoldenTestScenario(
              name: 'with value',
              constraints: const BoxConstraints(minWidth: 200),
              child: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextField(
                controller: TextEditingController(text: 'Value'),
                labelText: 'Label',
                autofocus: true,
                isPassword: isPassword,
              ),
            ),
            GoldenTestScenario(
              name: 'is focused w/ value',
              constraints: const BoxConstraints(minWidth: 200),
              child: Builder(
                builder: (BuildContext context) {
                  focusNode.requestFocus();

                  return {{#pascalCase}}{{project_name}}{{/pascalCase}}TextField(
                    controller: TextEditingController(text: 'Value'),
                    labelText: 'Label',
                    autofocus: true,
                    focusNode: focusNode,
                    isPassword: isPassword,
                  );
                },
              ),
            ),
          ],
        );

    goldenTest(
      'renders correctly when',
      fileName: '{{project_name.snakeCase()}}_text_field'.goldensVersion,
      builder: buildTextFieldTestGroup,
    );

    goldenTest(
      'renders correctly when isPassword is true',
      fileName: '{{project_name.snakeCase()}}_text_field_password'.goldensVersion,
      builder: () => buildTextFieldTestGroup(isPassword: true),
    );

    goldenTest(
      'renders correctly when is true and password is visible',
      fileName: '{{project_name.snakeCase()}}_text_field_password_visible'.goldensVersion,
      pumpBeforeTest: (WidgetTester tester) async {
        for (final Element element in find.byType(GestureDetector).evaluate()) {
          await tester.tapAt(tester.getCenter(find.byWidget(element.widget)));
        }
        await tester.pumpAndSettle();
      },
      builder: () => buildTextFieldTestGroup(isPassword: true),
    );
  });
}
