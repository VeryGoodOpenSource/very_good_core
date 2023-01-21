import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:{{project_name.snakeCase()}}/app/constants/enum.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/bloc/{{project_name.snakeCase()}}/{{project_name.snakeCase()}}_bloc.dart';
import 'package:{{project_name.snakeCase()}}/features/profile/presentation/screens/profile_screen.dart';

import '../../../../utils/golden_test_device_scenario.dart';
import '../../../../utils/mock_material_app.dart';
import '../../../../utils/test_utils.dart';
import 'profile_screen_test.mocks.dart';

@GenerateMocks(<Type>[{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc])
void main() {
  late Mock{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc {{#camelCase}}{{project_name}}{{/camelCase}}Bloc;

  setUp(() {
    {{#camelCase}}{{project_name}}{{/camelCase}}Bloc = Mock{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc();

    when({{#camelCase}}{{project_name}}{{/camelCase}}Bloc.stream).thenAnswer(
      (_) => Stream<{{#pascalCase}}{{project_name}}{{/pascalCase}}State>.fromIterable(<{{#pascalCase}}{{project_name}}{{/pascalCase}}State>[
        {{#pascalCase}}{{project_name}}{{/pascalCase}}State.initial().copyWith(
          authStatus: AuthStatus.authenticated,
          user: mockUser,
          isLoading: false,
        ),
      ]),
    );
    when({{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state).thenAnswer(
      (_) => {{#pascalCase}}{{project_name}}{{/pascalCase}}State.initial().copyWith(
        authStatus: AuthStatus.authenticated,
        user: mockUser,
        isLoading: false,
      ),
    );
  });
  Widget buildProfileScreen() => BlocProvider<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc>(
        create: (BuildContext context) => {{#camelCase}}{{project_name}}{{/camelCase}}Bloc,
        child: const MockMaterialApp(
          child: Scaffold(
            body: ProfileScreen(),
          ),
        ),
      );

  group('Profile Screen Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'profile_screen'.goldensVersion,
      pumpBeforeTest: (WidgetTester tester) async {
        await tester.pump(const Duration(seconds: 1));
      },
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestDeviceScenario(
            name: 'default',
            builder: buildProfileScreen,
          ),
        ],
      ),
    );
  });
}
