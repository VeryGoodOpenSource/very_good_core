import 'package:alchemist/alchemist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_core/core/presentation/widgets/very_good_core_info_text_field.dart';

import '../../../utils/test_utils.dart';

void main() {
  group('VeryGoodCoreInfoTextField Widget Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'very_good_core_info_text_field'.goldensVersion,
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestScenario(
            name: 'default(expanded)',
            constraints: const BoxConstraints(minWidth: 200),
            child: const VeryGoodCoreInfoTextField(
              title: 'Title',
              description: 'Description',
            ),
          ),
          GoldenTestScenario(
            name: 'shrink',
            child: const VeryGoodCoreInfoTextField(
              title: 'Title',
              description: 'Description',
              isExpanded: false,
            ),
          ),
        ],
      ),
    );
  });
}
