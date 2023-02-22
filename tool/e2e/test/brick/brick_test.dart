import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

/// Exit code indicating a command completed successfully.
///
/// [Source](https://www.freebsd.org/cgi/man.cgi?query=sysexits).
const _sucessfulExitCode = 0;

void main() {
  group('very_good_core brick', () {
    test(
      'creates a tested application',
      timeout: const Timeout(Duration(minutes: 2)),
      () async {
        final directory = Directory.current.createTempSync();

        final masonCliGetResult = await Process.run(
          'dart',
          ['pub', 'global', 'activate', 'mason_cli'],
          workingDirectory: directory.path,
          runInShell: true,
        );
        expect(
          masonCliGetResult.exitCode,
          equals(_sucessfulExitCode),
          reason: '`dart pub global activate mason_cli` failed',
        );
        expect(
          masonCliGetResult.stderr,
          isEmpty,
          reason: '`dart pub global activate mason_cli` failed',
        );

        final masonInitResult = await Process.run(
          'mason',
          ['init'],
          workingDirectory: directory.path,
          runInShell: true,
        );
        expect(
          masonInitResult.exitCode,
          0,
          reason: '`mason init` failed',
        );
        expect(
          masonInitResult.stderr,
          isEmpty,
          reason: '`mason init` failed',
        );

        final rootPath = directory.parent.parent.parent.path;
        final brickPath = path.join(rootPath, 'brick');
        final relativeBrickPath = path.relative(
          brickPath,
          from: directory.path,
        );
        final masonAddResult = await Process.run(
          'mason',
          ['add', 'very_good_core', '--path', relativeBrickPath],
          workingDirectory: directory.path,
          runInShell: true,
        );
        expect(
          masonAddResult.exitCode,
          equals(_sucessfulExitCode),
          reason: '`mason add very_good_core --path $relativeBrickPath` failed',
        );
        expect(
          masonAddResult.stderr,
          isEmpty,
          reason: '`mason add very_good_core --path $relativeBrickPath` failed',
        );

        final vars = {
          'project_name': 'test_app',
          'org_name': 'very_good_ventures',
          'application_id': 'verygood.ventures.test',
          'description': 'very_good_core test',
        };
        final variables =
            vars.entries.map((entry) => '--${entry.key} ${entry.value}');
        final masonMakeResult = await Process.run(
          'mason',
          ['make', 'very_good_core', ...variables],
          workingDirectory: directory.path,
          runInShell: true,
        );
        expect(
          masonMakeResult.exitCode,
          equals(_sucessfulExitCode),
          reason: '`mason make very_good_core ${variables.join(' ')}` failed',
        );
        expect(
          masonMakeResult.stderr,
          isEmpty,
          reason: '`mason make very_good_core ${variables.join(' ')}` failed',
        );

        // TODO(alestiago): figure out why this is 'my_app' and not 'test_app'
        final applicationPath = path.join(directory.path, 'my_app');

        final flutterPubGetResult = await Process.run(
          'flutter',
          ['pub', 'get'],
          workingDirectory: applicationPath,
          runInShell: true,
        );
        expect(
          flutterPubGetResult.exitCode,
          equals(_sucessfulExitCode),
          reason: '`flutter pub get` failed',
        );
        expect(
          flutterPubGetResult.stderr,
          isEmpty,
          reason: '`flutter pub get` failed',
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
          reason: '`flutter test` failed',
        );
        expect(
          flutterTest.stderr,
          isEmpty,
          reason: '`flutter test` failed',
        );

        directory.deleteSync(recursive: true);
      },
    );
  });
}
