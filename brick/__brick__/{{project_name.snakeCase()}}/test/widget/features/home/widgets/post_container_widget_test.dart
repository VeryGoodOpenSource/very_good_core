import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/model/value_objects.dart';
import 'package:{{project_name.snakeCase()}}/features/home/presentation/widgets/post_container.dart';

import '../../../../utils/golden_test_device_scenario.dart';
import '../../../../utils/mock_localization.dart';
import '../../../../utils/test_utils.dart';

void main() {
  group('PostContainer Widget Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'post_container'.goldensVersion,
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestDeviceScenario(
            name: 'default',
            builder: () => MockLocalization(
              child: Column(
                children: <Widget>[
                  PostContainer(post: mockPost),
                  const Spacer(),
                ],
              ),
            ),
          ),
          GoldenTestDeviceScenario(
            name: 'default',
            builder: () => MockLocalization(
              child: Column(
                children: <Widget>[
                  PostContainer(
                    post: mockPost.copyWith(
                      urlOverriddenByDest: Url('https://www.google.com/'),
                      selftext: ValueString(),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  });
}
