import 'package:alchemist/alchemist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:{{project_name.snakeCase()}}/core/presentation/widgets/{{project_name.snakeCase()}}_avatar.dart';

import '../../../utils/test_utils.dart';

void main() {
  group('{{#pascalCase}}{{project_name}}{{/pascalCase}}Avatar Widget Tests', () {
    goldenTest(
      'renders correctly',
      fileName: '{{project_name.snakeCase()}}_avatar'.goldensVersion,
      pumpWidget: (WidgetTester tester, Widget widget) async {
        await mockNetworkImages(
          () => tester.pumpWidget(widget, const Duration(seconds: 2)),
        );
      },
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestScenario(
            name: 'without image url',
            child: const {{#pascalCase}}{{project_name}}{{/pascalCase}}Avatar(
              size: 50,
            ),
          ),
          GoldenTestScenario(
            name: 'with image url',
            child: const {{#pascalCase}}{{project_name}}{{/pascalCase}}Avatar(
              size: 50,
              imageUrl: 'https://fakeurl.com/image.png',
            ),
          ),
        ],
      ),
    );
  });
}
