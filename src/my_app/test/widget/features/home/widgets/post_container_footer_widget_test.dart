import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_core/core/domain/model/value_objects.dart';
import 'package:very_good_core/features/home/presentation/widgets/post_container_footer.dart';

import '../../../../utils/mock_localization.dart';
import '../../../../utils/test_utils.dart';

void main() {
  group('PostContainerFooter Widget Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'post_container_footer'.goldensVersion,
      builder: () => GoldenTestGroup(
        children: <Widget>[
          GoldenTestScenario(
            name: 'default',
            child: MockLocalization(child: PostContainerFooter(post: mockPost)),
          ),
          GoldenTestScenario(
            name: 'with zero votes',
            child: MockLocalization(
              child: PostContainerFooter(
                post: mockPost.copyWith(upvotes: Number()),
              ),
            ),
          ),
        ],
      ),
    );
  });
}
