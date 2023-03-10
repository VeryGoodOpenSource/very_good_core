import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_core/counter/counter.dart';
import 'package:wearable_rotary/wearable_rotary.dart';

import '../../helpers/helpers.dart';

class MockCounterCubit extends MockCubit<int> implements CounterCubit {}

void main() {
  group('CounterRotaryListener', () {
    testWidgets('renders child', (tester) async {
      const child = SizedBox.shrink();
      await tester.pumpApp(
        CounterRotaryListener(child: child),
      );
      expect(find.byWidget(child), findsOneWidget);
    });

    group('on rotary events', () {
      late CounterCubit counterCubit;
      setUp(() {
        counterCubit = MockCounterCubit();
      });

      testWidgets('increments counter on clockwise events', (tester) async {
        final controller = StreamController<RotaryEvent>();

        addTearDown(controller.close);

        await tester.pumpApp(
          BlocProvider.value(
            value: counterCubit,
            child: CounterRotaryListener(
              rotaryEvents: controller.stream,
              child: const SizedBox.shrink(),
            ),
          ),
        );

        controller.add(
          const RotaryEvent(direction: RotaryDirection.clockwise),
        );
        await tester.pump();

        verify(() => counterCubit.increment()).called(1);

        controller.add(
          const RotaryEvent(direction: RotaryDirection.counterClockwise),
        );
        await tester.pump();

        verify(() => counterCubit.decrement()).called(1);
      });
    });
  });
}
