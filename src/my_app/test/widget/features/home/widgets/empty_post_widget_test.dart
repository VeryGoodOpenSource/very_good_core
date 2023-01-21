import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_core/features/home/presentation/widgets/empty_post.dart';

import '../../../../utils/golden_test_device_scenario.dart';
import '../../../../utils/mock_localization.dart';
import '../../../../utils/test_utils.dart';

void main() {
  group('EmptyPost Widget Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'empty_post'.goldensVersion,
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestDeviceScenario(
            name: 'default',
            builder: () => const MockLocalization(child: EmptyPost()),
          ),
        ],
      ),
    );
  });
}
