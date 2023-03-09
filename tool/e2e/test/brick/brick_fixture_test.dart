@Tags(['e2e'])
library brick_fixture_test;

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

void main() {
  test(
    'very_good_core brick matches test_app fixture content',
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
        reason: 'Generated application files do not match with fixture files.',
      );
      tempDirectory.deleteSync(recursive: true);
    },
  );
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
        _reason.writeln('Contents of file `$realtivePath` do not match.');
      }
    }

    return _reason.isEmpty;
  }
}
