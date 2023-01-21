import 'package:alchemist/alchemist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}/core/presentation/widgets/{{project_name.snakeCase()}}_info_text_field.dart';

import '../../../utils/test_utils.dart';

void main() {
  group('{{#pascalCase}}{{project_name}}{{/pascalCase}}InfoTextField Widget Tests', () {
    goldenTest(
      'renders correctly',
      fileName: '{{project_name.snakeCase()}}_info_text_field'.goldensVersion,
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestScenario(
            name: 'default(expanded)',
            constraints: const BoxConstraints(minWidth: 200),
            child: const {{#pascalCase}}{{project_name}}{{/pascalCase}}InfoTextField(
              title: 'Title',
              description: 'Description',
            ),
          ),
          GoldenTestScenario(
            name: 'shrink',
            child: const {{#pascalCase}}{{project_name}}{{/pascalCase}}InfoTextField(
              title: 'Title',
              description: 'Description',
              isExpanded: false,
            ),
          ),
        ],
      ),
    );
  });
}
