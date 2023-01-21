import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:very_good_core/app/constants/enum.dart';
import 'package:very_good_core/app/constants/route.dart';
import 'package:very_good_core/core/domain/bloc/very_good_core/very_good_core_bloc.dart';
import 'package:very_good_core/core/domain/model/failures.dart';
import 'package:very_good_core/core/presentation/screens/very_good_core_screen.dart';
import 'package:very_good_core/features/home/presentation/screens/home_screen.dart';
import 'package:very_good_core/features/profile/presentation/screens/profile_screen.dart';

import '../../../utils/golden_test_device_scenario.dart';
import '../../../utils/mock_go_router_provider.dart';
import '../../../utils/mock_material_app.dart';
import '../../../utils/test_utils.dart';
import 'very_good_core_screen_test.mocks.dart';

@GenerateMocks(<Type>[VeryGoodCoreBloc, GoRouter])
void main() {
  late MockVeryGoodCoreBloc veryGoodCoreBloc;
  late MockVeryGoodCoreBloc veryGoodCoreBlocError;
  late MockVeryGoodCoreBloc veryGoodCoreBlocLoading;
  late MockGoRouter routerHome;
  late MockGoRouter routerProfile;

  setUp(() {
    veryGoodCoreBloc = MockVeryGoodCoreBloc();
    veryGoodCoreBlocError = MockVeryGoodCoreBloc();
    veryGoodCoreBlocLoading = MockVeryGoodCoreBloc();
    routerHome = MockGoRouter();
    routerProfile = MockGoRouter();
    final VeryGoodCoreState state = VeryGoodCoreState.initial().copyWith(
      authStatus: AuthStatus.authenticated,
      user: mockUser,
      isLoading: false,
    );

    when(veryGoodCoreBloc.stream).thenAnswer(
      (_) => Stream<VeryGoodCoreState>.fromIterable(<VeryGoodCoreState>[state]),
    );
    when(veryGoodCoreBloc.state).thenAnswer((_) => state);
    when(veryGoodCoreBlocError.stream).thenAnswer(
      (_) => Stream<VeryGoodCoreState>.fromIterable(<VeryGoodCoreState>[
        state.copyWith(
          failure: const Failure.unexpected('Unexpected Error'),
        ),
      ]),
    );
    when(veryGoodCoreBlocError.state).thenAnswer(
      (_) =>
          state.copyWith(failure: const Failure.unexpected('Unexpected Error')),
    );
    when(veryGoodCoreBlocLoading.stream).thenAnswer(
      (_) => Stream<VeryGoodCoreState>.fromIterable(<VeryGoodCoreState>[
        state.copyWith(isLoading: true, user: null, failure: null),
      ]),
    );
    when(veryGoodCoreBlocLoading.state).thenAnswer(
      (_) => state.copyWith(isLoading: true, user: null, failure: null),
    );
    when(routerHome.location).thenAnswer((_) => RouteName.home.path);
    when(routerProfile.location).thenAnswer((_) => RouteName.profile.path);
    when(routerProfile.canPop()).thenAnswer((_) => false);
    when(routerHome.canPop()).thenAnswer((_) => false);
  });

  Widget buildVeryGoodCoreScreen(
    Widget child,
    GoRouter router,
    VeryGoodCoreBloc veryGoodCoreBloc,
  ) =>
      MockMaterialApp(
        child: MockGoRouterProvider(
          router: router,
          child: BlocProvider<VeryGoodCoreBloc>(
            create: (BuildContext context) => veryGoodCoreBloc,
            child: Scaffold(
              body: VeryGoodCoreScreen(
                child: child,
              ),
            ),
          ),
        ),
      );

  group('VeryGoodCore Screen Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'very_good_core_screen'.goldensVersion,
      pumpBeforeTest: (WidgetTester tester) async {
        await tester.pumpAndSettle(const Duration(seconds: 1));
      },
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestDeviceScenario(
            name: 'home',
            builder: () => buildVeryGoodCoreScreen(
              const HomeScreen(),
              routerHome,
              veryGoodCoreBloc,
            ),
          ),
          GoldenTestDeviceScenario(
            name: 'profile',
            builder: () => buildVeryGoodCoreScreen(
              const ProfileScreen(),
              routerProfile,
              veryGoodCoreBloc,
            ),
          ),
          GoldenTestDeviceScenario(
            name: 'error',
            builder: () => buildVeryGoodCoreScreen(
              const HomeScreen(),
              routerHome,
              veryGoodCoreBlocError,
            ),
          ),
        ],
      ),
    );
    goldenTest(
      'renders correctly',
      fileName: 'very_good_core_screen_loading'.goldensVersion,
      pumpBeforeTest: (WidgetTester tester) async {
        await tester.pump(const Duration(seconds: 1));
      },
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestDeviceScenario(
            name: 'loading',
            builder: () => buildVeryGoodCoreScreen(
              const HomeScreen(),
              routerHome,
              veryGoodCoreBlocLoading,
            ),
          ),
        ],
      ),
    );
  });
}
