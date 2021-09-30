import 'dart:io';
import 'package:path/path.dart' as path;

final _sourcePath = path.join('app');
final _targetPath = path.join('brick', '__brick__');
final _androidPath = path.join(_targetPath, 'android');
final _androidKotlinPath =
    path.join(_androidPath, 'app', 'src', 'main', 'kotlin');
final _orgPath = path.join(_androidKotlinPath, 'com');
final _staticDir = path.join('tool', 'generator', 'static');
const copyrightHeader = '''
// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
''';

void main() async {
  // Remove Previously Generated Files
  final targetDir = Directory(_targetPath);
  if (targetDir.existsSync()) {
    await targetDir.delete(recursive: true);
  }

  // Copy Project Files
  await Shell.cp(_sourcePath, _targetPath);

  Directory(_orgPath).deleteSync(recursive: true);

  // Convert Values to Variables
  await Future.wait(
    Directory(_targetPath)
        .listSync(recursive: true)
        .whereType<File>()
        .map((_) async {
      var file = _;

      try {
        if (path.extension(file.path) == '.dart') {
          final contents = await file.readAsString();
          file = await file.writeAsString('$copyrightHeader\n$contents');
        }

        final contents = await file.readAsString();
        file = await file.writeAsString(
          contents
              .replaceAll(
                'very_good_core',
                '{{#snakeCase}}{{project_name}}{{/snakeCase}}',
              )
              .replaceAll(
                'very-good-core',
                '{{#paramCase}}{{project_name}}{{/paramCase}}',
              )
              .replaceAll(
                'A new Flutter project.',
                '{{#sentenceCase}}{{description}}{{/sentenceCase}}',
              )
              .replaceAll(
                'Very Good Core',
                '{{#titleCase}}{{project_name}}{{/titleCase}}',
              )
              .replaceAll(
                'com.example.veryGoodCore',
                path.isWithin(_androidPath, file.path)
                    ? '{{#dotCase}}{{org_name}}{{/dotCase}}.{{#snakeCase}}{{project_name}}{{/snakeCase}}'
                    : '{{#dotCase}}{{org_name}}{{/dotCase}}.{{#paramCase}}{{project_name}}{{/paramCase}}',
              ),
        );
        final fileSegments = file.path.split('/').sublist(2);
        if (fileSegments.contains('very_good_core')) {
          final newPathSegment = fileSegments.join('/').replaceAll(
                'very_good_core',
                '{{#snakeCase}}{{project_name}}{{/snakeCase}}',
              );
          final newPath = path.join(_targetPath, newPathSegment);
          File(newPath).createSync(recursive: true);
          file.renameSync(newPath);
          Directory(file.parent.path).deleteSync(recursive: true);
        }
      } catch (_) {}
    }),
  );

  final mainActivityKt = File(
    path.join(
      _androidKotlinPath,
      '{{#pathCase}}{{org_name}}{{/pathCase}}',
      'MainActivity.kt',
    ),
  );

  await Shell.mkdir(mainActivityKt.parent.path);
  await Shell.cp(path.join(_staticDir, 'MainActivity.kt'), mainActivityKt.path);
}

class Shell {
  static Future<void> cp(String source, String destination) {
    return _Cmd.run('cp', ['-rf', source, destination]);
  }

  static Future<void> mkdir(String destination) {
    return _Cmd.run('mkdir', ['-p', destination]);
  }
}

class _Cmd {
  static Future<ProcessResult> run(
    String cmd,
    List<String> args, {
    bool throwOnError = true,
    String? processWorkingDir,
  }) async {
    final result = await Process.run(cmd, args,
        workingDirectory: processWorkingDir, runInShell: true);

    if (throwOnError) {
      _throwIfProcessFailed(result, cmd, args);
    }
    return result;
  }

  static void _throwIfProcessFailed(
    ProcessResult pr,
    String process,
    List<String> args,
  ) {
    if (pr.exitCode != 0) {
      final values = {
        'Standard out': pr.stdout.toString().trim(),
        'Standard error': pr.stderr.toString().trim()
      }..removeWhere((k, v) => v.isEmpty);

      String message;
      if (values.isEmpty) {
        message = 'Unknown error';
      } else if (values.length == 1) {
        message = values.values.single;
      } else {
        message = values.entries.map((e) => '${e.key}\n${e.value}').join('\n');
      }

      throw ProcessException(process, args, message, pr.exitCode);
    }
  }
}
