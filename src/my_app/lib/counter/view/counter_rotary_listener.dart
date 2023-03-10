import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_core/counter/cubit/counter_cubit.dart';
import 'package:wearable_rotary/wearable_rotary.dart' as wearable_rotary;
import 'package:wearable_rotary/wearable_rotary.dart' hide rotaryEvents;

/// A [StatefulWidget] that parses events on [rotaryEvents] and updates
/// the [CounterCubit].
class CounterRotaryListener extends StatefulWidget {
  CounterRotaryListener({
    required this.child,
    super.key,
    Stream<RotaryEvent>? rotaryEvents,
  }) : rotaryEvents = rotaryEvents ?? wearable_rotary.rotaryEvents;

  final Widget child;

  final Stream<RotaryEvent> rotaryEvents;

  @override
  State<CounterRotaryListener> createState() => _CounterRotaryListenerState();
}

class _CounterRotaryListenerState extends State<CounterRotaryListener> {
  late final StreamSubscription<RotaryEvent> rotarySubscription;

  @override
  void initState() {
    super.initState();
    rotarySubscription = widget.rotaryEvents.listen((event) {
      final cubit = context.read<CounterCubit>();
      if (event.direction == RotaryDirection.clockwise) {
        cubit.increment();
      } else {
        cubit.decrement();
      }
    });
  }

  @override
  void dispose() {
    rotarySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
