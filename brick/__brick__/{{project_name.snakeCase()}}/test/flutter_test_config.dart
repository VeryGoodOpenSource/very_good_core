import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/app_theme.dart';

import 'utils/local_file_comparator_with_threshold.dart';
import 'utils/test_utils.dart';

class TestConfig {
  /// Update this if you want to update the golden files in the remote repository
  /// Format: yyyyMMddHHmm
  static String get goldensVersion => '202301071800';

  /// Customize your threshold here
  /// For example, the error threshold here is 15%
  /// Golden tests will pass if the pixel difference is equal to or below 15%
  static double get goldenTestsThreshold => 15 / 100;
}

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await loadAppFonts();
  await setupInjection();
  if (goldenFileComparator is LocalFileComparator) {
    final Uri testUrl = (goldenFileComparator as LocalFileComparator).basedir;

    goldenFileComparator = LocalFileComparatorWithThreshold(
      // flutter_test's LocalFileComparator expects the test's URI to be passed
      // as an argument, but it only uses it to parse the baseDir in order to
      // obtain the directory where the golden tests will be placed.
      // As such, we use the default `testUrl`, which is only the `baseDir` and
      // append a generically named `test.dart` so that the `baseDir` is
      // properly extracted.
      Uri.parse('$testUrl/test.dart'),
      TestConfig.goldenTestsThreshold,
    );
  } else {
    throw Exception(
      'Expected `goldenFileComparator` to be of type `LocalFileComparator`, '
      'but it is of type `${goldenFileComparator.runtimeType}`',
    );
  }

  return AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      platformGoldensConfig: PlatformGoldensConfig(
        // ignore: avoid_redundant_argument_values
        enabled: !const bool.fromEnvironment('CI', defaultValue: false),
        theme: AppTheme.lightTheme,
      ),
      ciGoldensConfig: CiGoldensConfig(
        theme: AppTheme.lightTheme,
      ),
    ),
    run: testMain,
  );
}
