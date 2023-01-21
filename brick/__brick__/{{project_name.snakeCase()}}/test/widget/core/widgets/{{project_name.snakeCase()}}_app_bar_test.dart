import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/model/value_objects.dart';
import 'package:{{project_name.snakeCase()}}/core/presentation/widgets/{{project_name.snakeCase()}}_app_bar.dart';

import '../../../utils/mock_go_router_provider.dart';
import '../../../utils/test_utils.dart';
import '{{project_name.snakeCase()}}_app_bar_test.mocks.dart';

@GenerateMocks(<Type>[GoRouter])
void main() {
  late MockGoRouter routerWithBack;
  late MockGoRouter routerWithOutBack;

  setUp(() {
    routerWithBack = MockGoRouter();
    routerWithOutBack = MockGoRouter();
    when(routerWithBack.canPop()).thenAnswer((_) => true);
    when(routerWithOutBack.canPop()).thenAnswer((_) => false);
  });

  group('{{#pascalCase}}{{project_name}}{{/pascalCase}}AppBar Widget Tests', () {
    goldenTest(
      'renders correctly',
      fileName: '{{project_name.snakeCase()}}_app_bar'.goldensVersion,
      pumpWidget: (WidgetTester tester, Widget widget) async {
        await mockNetworkImages(() => tester.pumpWidget(widget));
      },
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestScenario(
            name: 'without avatar and back button',
            child: PreferredSize(
              preferredSize: Size.fromHeight(AppBar().preferredSize.height),
              child: MockGoRouterProvider(
                router: routerWithOutBack,
                child: const {{#pascalCase}}{{project_name}}{{/pascalCase}}AppBar(),
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'with avatar but no back button',
            child: PreferredSize(
              preferredSize: Size.fromHeight(AppBar().preferredSize.height),
              child: MockGoRouterProvider(
                router: routerWithOutBack,
                child: {{#pascalCase}}{{project_name}}{{/pascalCase}}AppBar(
                  avatar: Url('https://reqres.in/img/faces/2-image.jpg'),
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'without avatar but have a back button',
            child: PreferredSize(
              preferredSize: Size.fromHeight(AppBar().preferredSize.height),
              child: MockGoRouterProvider(
                router: routerWithBack,
                child: const {{#pascalCase}}{{project_name}}{{/pascalCase}}AppBar(),
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'with avatar and back button',
            child: PreferredSize(
              preferredSize: Size.fromHeight(AppBar().preferredSize.height),
              child: MockGoRouterProvider(
                router: routerWithBack,
                child: {{#pascalCase}}{{project_name}}{{/pascalCase}}AppBar(
                  avatar: Url('https://reqres.in/img/faces/2-image.jpg'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  });
}
