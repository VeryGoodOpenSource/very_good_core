import 'package:alchemist/alchemist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_core/core/domain/model/value_objects.dart';
import 'package:very_good_core/core/presentation/widgets/very_good_core_text_url.dart';

import '../../../utils/test_utils.dart';

void main() {
  group('VeryGoodCoreTextUrl Widget Tests', () {
    int count = 0;
    goldenTest(
      'renders correctly',
      fileName: 'very_good_core_text_url'.goldensVersion,
      constraints: const BoxConstraints(minWidth: 200),
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestScenario(
            name: 'default',
            child: SizedBox(
              height: 20,
              child: VeryGoodCoreTextUrl(
                url: Url('https://www.example.com'),
                onTap: () => count++,
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'no icon',
            child: SizedBox(
              height: 20,
              child: VeryGoodCoreTextUrl(
                url: Url('https://www.example.com'),
                onTap: () => count++,
                isShowIcon: false,
              ),
            ),
          ),
        ],
      ),
    );
  });
}
