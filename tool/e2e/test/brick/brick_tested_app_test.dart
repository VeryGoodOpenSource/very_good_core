@Tags(['e2e'])
library brick_tested_app_test;

import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

/// Exit code indicating a command completed successfully.
///
/// [Source](https://www.freebsd.org/cgi/man.cgi?query=sysexits).
const _sucessfulExitCode = 0;

void main() {
  test(
    'very_good_core brick creates a tested application',
    timeout: const Timeout(Duration(minutes: 2)),
    () async {
      final rootPath = Directory.current.parent.parent.path;
      final brickPath = path.join(rootPath, 'brick');
      final brick = Brick.path(brickPath);
      final masonGenerator = await MasonGenerator.fromBrick(brick);
      final tempDirectory = Directory.systemTemp.createTempSync();
      final directoryGeneratorTarget = DirectoryGeneratorTarget(
        tempDirectory,
      );
      var vars = <String, dynamic>{
        'project_name': 'test_app',
        'org_name': 'very_good_ventures',
        'application_id': 'verygood.ventures.test',
        'description': 'very_good_core test',
      };

      await masonGenerator.hooks.preGen(
        workingDirectory: directoryGeneratorTarget.dir.path,
        vars: vars,
        onVarsChanged: (newVars) => vars = newVars,
      );
      await masonGenerator.generate(directoryGeneratorTarget, vars: vars);
      await masonGenerator.hooks.postGen(
        workingDirectory: directoryGeneratorTarget.dir.path,
        vars: vars,
      );

      final applicationPath = path.join(
        directoryGeneratorTarget.dir.path,
        vars['project_name'] as String,
      );
      final flutterPubGetResult = await Process.run(
        'flutter',
        ['pub', 'get'],
        workingDirectory: applicationPath,
        runInShell: true,
      );
      expect(
        flutterPubGetResult.exitCode,
        equals(_sucessfulExitCode),
        reason: '`flutter pub get` at $applicationPath failed with error:\n '
            '- ${flutterPubGetResult.stderr}',
      );
      expect(
        flutterPubGetResult.stderr,
        isEmpty,
        reason: '`flutter pub get` at $applicationPath failed with error:\n '
            '- ${flutterPubGetResult.stderr}',
      );

      final flutterTest = await Process.run(
        'flutter',
        ['test'],
        workingDirectory: applicationPath,
        runInShell: true,
      );
      expect(
        flutterTest.exitCode,
        equals(_sucessfulExitCode),
        reason: '`flutter test` at $applicationPath failed with error:\n '
            ' - ${flutterTest.stderr}',
      );
      expect(
        flutterTest.stderr,
        isEmpty,
        reason: '`flutter test` at $applicationPath failed with error:\n '
            '- ${flutterTest.stderr}',
      );

      tempDirectory.deleteSync(recursive: true);
    },
  );
}
