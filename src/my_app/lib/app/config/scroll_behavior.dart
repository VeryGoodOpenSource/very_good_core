import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScrollBehaviorConfig extends ScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
