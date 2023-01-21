import 'dart:io';

import 'package:path/path.dart' as path;

final _sourcePath = path.join('src');
final _targetPath = path.join('brick', '__brick__');
final _androidPath = path.join(_targetPath, 'my_app', 'android');
final _androidKotlinPath =
    path.join(_androidPath, 'app', 'src', 'main', 'kotlin');
final _orgPath = path.join(_androidKotlinPath, 'com');
final _staticDir = path.join('tool', 'generator', 'static');

extension GeneratorStringX on String {
  String replaceApplicationId(String filePath) {
    final isAndroid = path.isWithin(_androidPath, filePath);

    if (isAndroid && filePath.endsWith('build.gradle')) {
      return replaceAll(
        'com.example.very_good_core',
        '{{application_id_android}}',
      );
    } else if (isAndroid) {
      return replaceAll(
        'com.example.very_good_core',
        '{{org_name.dotCase()}}.{{project_name.snakeCase()}}',
      );
    } else {
      return replaceAll('com.example.very_good_core', '{{application_id}}');
    }
  }
}

void main() async {
  // Remove Previously Generated Files
  final targetDir = Directory(_targetPath);
  if (targetDir.existsSync()) {
    await targetDir.delete(recursive: true);
  }

  // Copy Project Files
  await Shell.cp(_sourcePath, _targetPath);

  // Delete Android's Organization Folder Hierarchy
  Directory(_orgPath).deleteSync(recursive: true);

  // Convert Values to Variables
  await Future.wait(
    Directory(path.join(_targetPath, 'my_app'))
        .listSync(recursive: true)
        .whereType<File>()
        .map((File element) async {
      File file = element;
      try {
        final contents = await file.readAsString();

        if (path.basename(file.path) == 'LICENSE') {
          await file.delete(recursive: true);
          return;
        }

        if (file.path.endsWith('Info.plist')) {
          file = await file.writeAsString(contents.replaceAll(
            '<string>Very Good Core</string>',
            r'<string>$(FLAVOR_APP_NAME)</string>',
          ));
        }

        file = await file.writeAsString(
          contents
              .replaceApplicationId(file.path)
              .replaceAll('very-good-core', '{{project_name.paramCase()}}')
              .replaceAll('A Very Good App', '{{{description}}}')
              .replaceAll('Very Good Core', '{{project_name.titleCase()}}')
              .replaceAll('VeryGoodCore',
                  '{{#pascalCase}}{{project_name}}{{/pascalCase}}')
              .replaceAll('veryGoodCore',
                  '{{#camelCase}}{{project_name}}{{/camelCase}}')
              .replaceAll('very_good_core', '{{project_name.snakeCase()}}'),
        );

        final fileSegments = file.path.split('/').sublist(2);

        if (fileSegments
            .any((String element) => element.contains('very_good_core'))) {
          final newPathSegment = fileSegments.join('/').replaceAll(
                'very_good_core',
                '{{project_name.snakeCase()}}',
              );
          final newPath = path.join(_targetPath, newPathSegment);
          File(newPath).createSync(recursive: true);
          file.renameSync(newPath);
        }
      } catch (_) {}
    }),
  );

  // Convert Golden Files to Variables

  await Future.wait(Directory(path.join(_targetPath, 'my_app'))
      .listSync(recursive: true)
      .where((element) =>
          element.path.split('.').last.toLowerCase().contains('png'))
      .map((element) async {
    var file = element;
    final fileSegments = file.path.split('/').sublist(2);

    if (fileSegments
        .any((String element) => element.contains('very_good_core'))) {
      final newPathSegment = fileSegments.join('/').replaceAll(
            'very_good_core',
            '{{project_name.snakeCase()}}',
          );
      final newPath = path.join(_targetPath, newPathSegment);
      File(newPath).createSync(recursive: true);
      file.renameSync(newPath);
    }
  }));

  final mainActivityKt = File(
    path.join(
      _androidKotlinPath.replaceAll('my_app', '{{project_name.snakeCase()}}'),
      '{{org_name.pathCase()}}',
      'MainActivity.kt',
    ),
  );

  await Shell.mkdir(mainActivityKt.parent.path);
  await Shell.cp(path.join(_staticDir, 'MainActivity.kt'), mainActivityKt.path);
  await Shell.rename(
    path.join(_targetPath, 'my_app'),
    path.join(_targetPath, '{{project_name.snakeCase()}}'),
  );
}

class Shell {
  static Future<void> cp(String source, String destination) {
    return _Cmd.run('cp', ['-rf', source, destination]);
  }

  static Future<void> mkdir(String destination) {
    return _Cmd.run('mkdir', ['-p', destination]);
  }

  static Future<void> rename(String source, String destination) async {
    await Shell.cp('$source/', '$destination/');
    await _Cmd.run('rm', ['-rf', source]);
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
