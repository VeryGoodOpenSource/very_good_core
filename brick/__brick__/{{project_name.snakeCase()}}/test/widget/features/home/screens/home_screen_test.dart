import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:{{project_name.snakeCase()}}/features/home/domain/bloc/post/post_bloc.dart';
import 'package:{{project_name.snakeCase()}}/features/home/presentation/screens/home_screen.dart';

import '../../../../utils/golden_test_device_scenario.dart';
import '../../../../utils/mock_material_app.dart';
import '../../../../utils/test_utils.dart';
import 'home_screen_test.mocks.dart';

@GenerateMocks(<Type>[PostBloc])
void main() {
  late MockPostBloc postBlocInitial;
  late MockPostBloc postBlocWithPosts;

  setUp(() {
    postBlocInitial = MockPostBloc();
    postBlocWithPosts = MockPostBloc();
    when(postBlocInitial.stream).thenAnswer(
      (_) => Stream<PostState>.fromIterable(<PostState>[PostState.initial()]),
    );
    when(postBlocInitial.state).thenAnswer((_) => PostState.initial());
    when(postBlocWithPosts.stream).thenAnswer(
      (_) => Stream<PostState>.fromIterable(
        <PostState>[PostState.initial().copyWith(posts: mockPosts)],
      ),
    );
    when(postBlocWithPosts.state)
        .thenAnswer((_) => PostState.initial().copyWith(posts: mockPosts));
  });

  Widget buildHomeScreen(PostBloc postBloc) => BlocProvider<PostBloc>(
        create: (BuildContext context) => postBloc,
        child: const MockMaterialApp(
          child: Scaffold(
            body: HomeScreen(),
          ),
        ),
      );

  group('Home Screen Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'home_screen'.goldensVersion,
      pumpBeforeTest: (WidgetTester tester) async {
        await tester.pumpAndSettle(const Duration(seconds: 1));
      },
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestDeviceScenario(
            name: 'initial',
            builder: () => buildHomeScreen(postBlocInitial),
          ),
          GoldenTestDeviceScenario(
            name: 'with posts',
            builder: () => buildHomeScreen(postBlocWithPosts),
          ),
        ],
      ),
    );
  });
}
