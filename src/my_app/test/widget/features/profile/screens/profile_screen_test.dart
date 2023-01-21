import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:very_good_core/app/constants/enum.dart';
import 'package:very_good_core/core/domain/bloc/very_good_core/very_good_core_bloc.dart';
import 'package:very_good_core/features/profile/presentation/screens/profile_screen.dart';

import '../../../../utils/golden_test_device_scenario.dart';
import '../../../../utils/mock_material_app.dart';
import '../../../../utils/test_utils.dart';
import 'profile_screen_test.mocks.dart';

@GenerateMocks(<Type>[VeryGoodCoreBloc])
void main() {
  late MockVeryGoodCoreBloc veryGoodCoreBloc;

  setUp(() {
    veryGoodCoreBloc = MockVeryGoodCoreBloc();

    when(veryGoodCoreBloc.stream).thenAnswer(
      (_) => Stream<VeryGoodCoreState>.fromIterable(<VeryGoodCoreState>[
        VeryGoodCoreState.initial().copyWith(
          authStatus: AuthStatus.authenticated,
          user: mockUser,
          isLoading: false,
        ),
      ]),
    );
    when(veryGoodCoreBloc.state).thenAnswer(
      (_) => VeryGoodCoreState.initial().copyWith(
        authStatus: AuthStatus.authenticated,
        user: mockUser,
        isLoading: false,
      ),
    );
  });
  Widget buildProfileScreen() => BlocProvider<VeryGoodCoreBloc>(
        create: (BuildContext context) => veryGoodCoreBloc,
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
