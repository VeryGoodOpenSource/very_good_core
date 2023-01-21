import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}/core/presentation/widgets/{{project_name.snakeCase()}}_dialogs.dart';

import '../../../utils/golden_test_device_scenario.dart';
import '../../../utils/mock_localization.dart';
import '../../../utils/test_utils.dart';

void main() {
  group('Dialog Widget Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'confirmation_dialog'.goldensVersion,
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestDeviceScenario(
            name: 'default',
            builder: () => const MockLocalization(
              child: ConfirmationDialog(message: 'message'),
            ),
          ),
          GoldenTestDeviceScenario(
            name: 'with title',
            builder: () => const MockLocalization(
              child: ConfirmationDialog(message: 'message', title: 'title'),
            ),
          ),
        ],
      ),
    );
  });
}
