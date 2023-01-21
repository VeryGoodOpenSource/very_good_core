import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:{{project_name.snakeCase()}}/app/constants/enum.dart';
import 'package:{{project_name.snakeCase()}}/app/constants/route.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/bloc/{{project_name.snakeCase()}}/{{project_name.snakeCase()}}_bloc.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/model/failures.dart';
import 'package:{{project_name.snakeCase()}}/core/presentation/screens/{{project_name.snakeCase()}}_screen.dart';
import 'package:{{project_name.snakeCase()}}/features/home/presentation/screens/home_screen.dart';
import 'package:{{project_name.snakeCase()}}/features/profile/presentation/screens/profile_screen.dart';

import '../../../utils/golden_test_device_scenario.dart';
import '../../../utils/mock_go_router_provider.dart';
import '../../../utils/mock_material_app.dart';
import '../../../utils/test_utils.dart';
import '{{project_name.snakeCase()}}_screen_test.mocks.dart';

@GenerateMocks(<Type>[{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc, GoRouter])
void main() {
  late Mock{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc {{#camelCase}}{{project_name}}{{/camelCase}}Bloc;
  late Mock{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc {{#camelCase}}{{project_name}}{{/camelCase}}BlocError;
  late Mock{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc {{#camelCase}}{{project_name}}{{/camelCase}}BlocLoading;
  late MockGoRouter routerHome;
  late MockGoRouter routerProfile;

  setUp(() {
    {{#camelCase}}{{project_name}}{{/camelCase}}Bloc = Mock{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc();
    {{#camelCase}}{{project_name}}{{/camelCase}}BlocError = Mock{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc();
    {{#camelCase}}{{project_name}}{{/camelCase}}BlocLoading = Mock{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc();
    routerHome = MockGoRouter();
    routerProfile = MockGoRouter();
    final {{#pascalCase}}{{project_name}}{{/pascalCase}}State state = {{#pascalCase}}{{project_name}}{{/pascalCase}}State.initial().copyWith(
      authStatus: AuthStatus.authenticated,
      user: mockUser,
      isLoading: false,
    );

    when({{#camelCase}}{{project_name}}{{/camelCase}}Bloc.stream).thenAnswer(
      (_) => Stream<{{#pascalCase}}{{project_name}}{{/pascalCase}}State>.fromIterable(<{{#pascalCase}}{{project_name}}{{/pascalCase}}State>[state]),
    );
    when({{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state).thenAnswer((_) => state);
    when({{#camelCase}}{{project_name}}{{/camelCase}}BlocError.stream).thenAnswer(
      (_) => Stream<{{#pascalCase}}{{project_name}}{{/pascalCase}}State>.fromIterable(<{{#pascalCase}}{{project_name}}{{/pascalCase}}State>[
        state.copyWith(
          failure: const Failure.unexpected('Unexpected Error'),
        ),
      ]),
    );
    when({{#camelCase}}{{project_name}}{{/camelCase}}BlocError.state).thenAnswer(
      (_) =>
          state.copyWith(failure: const Failure.unexpected('Unexpected Error')),
    );
    when({{#camelCase}}{{project_name}}{{/camelCase}}BlocLoading.stream).thenAnswer(
      (_) => Stream<{{#pascalCase}}{{project_name}}{{/pascalCase}}State>.fromIterable(<{{#pascalCase}}{{project_name}}{{/pascalCase}}State>[
        state.copyWith(isLoading: true, user: null, failure: null),
      ]),
    );
    when({{#camelCase}}{{project_name}}{{/camelCase}}BlocLoading.state).thenAnswer(
      (_) => state.copyWith(isLoading: true, user: null, failure: null),
    );
    when(routerHome.location).thenAnswer((_) => RouteName.home.path);
    when(routerProfile.location).thenAnswer((_) => RouteName.profile.path);
    when(routerProfile.canPop()).thenAnswer((_) => false);
    when(routerHome.canPop()).thenAnswer((_) => false);
  });

  Widget build{{#pascalCase}}{{project_name}}{{/pascalCase}}Screen(
    Widget child,
    GoRouter router,
    {{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc {{#camelCase}}{{project_name}}{{/camelCase}}Bloc,
  ) =>
      MockMaterialApp(
        child: MockGoRouterProvider(
          router: router,
          child: BlocProvider<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc>(
            create: (BuildContext context) => {{#camelCase}}{{project_name}}{{/camelCase}}Bloc,
            child: Scaffold(
              body: {{#pascalCase}}{{project_name}}{{/pascalCase}}Screen(
                child: child,
              ),
            ),
          ),
        ),
      );

  group('{{#pascalCase}}{{project_name}}{{/pascalCase}} Screen Tests', () {
    goldenTest(
      'renders correctly',
      fileName: '{{project_name.snakeCase()}}_screen'.goldensVersion,
      pumpBeforeTest: (WidgetTester tester) async {
        await tester.pumpAndSettle(const Duration(seconds: 1));
      },
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestDeviceScenario(
            name: 'home',
            builder: () => build{{#pascalCase}}{{project_name}}{{/pascalCase}}Screen(
              const HomeScreen(),
              routerHome,
              {{#camelCase}}{{project_name}}{{/camelCase}}Bloc,
            ),
          ),
          GoldenTestDeviceScenario(
            name: 'profile',
            builder: () => build{{#pascalCase}}{{project_name}}{{/pascalCase}}Screen(
              const ProfileScreen(),
              routerProfile,
              {{#camelCase}}{{project_name}}{{/camelCase}}Bloc,
            ),
          ),
          GoldenTestDeviceScenario(
            name: 'error',
            builder: () => build{{#pascalCase}}{{project_name}}{{/pascalCase}}Screen(
              const HomeScreen(),
              routerHome,
              {{#camelCase}}{{project_name}}{{/camelCase}}BlocError,
            ),
          ),
        ],
      ),
    );
    goldenTest(
      'renders correctly',
      fileName: '{{project_name.snakeCase()}}_screen_loading'.goldensVersion,
      pumpBeforeTest: (WidgetTester tester) async {
        await tester.pump(const Duration(seconds: 1));
      },
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestDeviceScenario(
            name: 'loading',
            builder: () => build{{#pascalCase}}{{project_name}}{{/pascalCase}}Screen(
              const HomeScreen(),
              routerHome,
              {{#camelCase}}{{project_name}}{{/camelCase}}BlocLoading,
            ),
          ),
        ],
      ),
    );
  });
}
