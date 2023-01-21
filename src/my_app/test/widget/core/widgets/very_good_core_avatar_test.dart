import 'package:alchemist/alchemist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:very_good_core/core/presentation/widgets/very_good_core_avatar.dart';

import '../../../utils/test_utils.dart';

void main() {
  group('VeryGoodCoreAvatar Widget Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'very_good_core_avatar'.goldensVersion,
      pumpWidget: (WidgetTester tester, Widget widget) async {
        await mockNetworkImages(
          () => tester.pumpWidget(widget, const Duration(seconds: 2)),
        );
      },
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestScenario(
            name: 'without image url',
            child: const VeryGoodCoreAvatar(
              size: 50,
            ),
          ),
          GoldenTestScenario(
            name: 'with image url',
            child: const VeryGoodCoreAvatar(
              size: 50,
              imageUrl: 'https://fakeurl.com/image.png',
            ),
          ),
        ],
      ),
    );
  });
}
