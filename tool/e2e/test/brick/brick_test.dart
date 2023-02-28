@Tags(['e2e'])
library e2e;

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

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

        tempDirectory.deleteSync(recursive: true);
      },
    );

    test(
      'matches test_app fixture content',
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

        final fixturesPath = path.join(rootPath, 'tool', 'e2e', 'fixtures');
        final fixtureConfig = path.join(fixturesPath, 'test_app_config.json');
        final fixtureConfigString = File(fixtureConfig).readAsStringSync();
        var vars = jsonDecode(fixtureConfigString) as Map<String, dynamic>;

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
        final fixturePath = path.join(
          fixturesPath,
          vars['project_name'] as String,
        );

        expect(
          Directory(applicationPath),
          _DirectoryContentMatcher(Directory(fixturePath)),
        );
        tempDirectory.deleteSync(recursive: true);
      },
    );
  });
}

class _DirectoryContentMatcher extends Matcher {
  _DirectoryContentMatcher(this._expected);

  final Directory _expected;

  final _reason = StringBuffer();

  @override
  Description describe(Description description) {
    return description.add(_reason.toString());
  }

  @override
  bool matches(covariant Directory item, Map<dynamic, dynamic> matchState) {
    _reason.clear();
    final dirAContents = _expected.listSync(recursive: true).whereType<File>();
    final dirBContents = item.listSync(recursive: true).whereType<File>();

    if (dirAContents.length != dirBContents.length) {
      _reason.write(
        'Directory contents do not match, expected '
        '${dirAContents.length} files, found ${dirBContents.length} files',
      );
      return false;
    }

    final files = <String, Digest>{};
    for (final file in dirAContents) {
      final realtivePath = path.relative(file.path, from: _expected.path);
      final bytes = file.readAsBytesSync();
      final digest = sha1.convert(bytes);
      files[realtivePath] = digest;
    }
    for (final file in dirBContents) {
      final realtivePath = path.relative(file.path, from: item.path);
      final bytes = file.readAsBytesSync();
      final digest = sha1.convert(bytes);
      if (files[realtivePath] != digest) {
        _reason.write('Contents of file `$realtivePath` do not match.');
      }
    }

    return _reason.isEmpty;
  }
}
