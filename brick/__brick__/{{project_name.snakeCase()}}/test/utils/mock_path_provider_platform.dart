import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
// ignore: depend_on_referenced_packages
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  final String kTemporaryPath = 'temporaryPath';
  final String kApplicationSupportPath = 'applicationSupportPath';
  final String kDownloadsPath = 'downloadsPath';
  final String kLibraryPath = 'libraryPath';
  final String kApplicationDocumentsPath = 'applicationDocumentsPath';
  final String kExternalCachePath = 'externalCachePath';
  final String kExternalStoragePath = 'externalStoragePath';

  @override
  Future<String?> getTemporaryPath() async => kTemporaryPath;

  @override
  Future<String?> getApplicationSupportPath() async => kApplicationSupportPath;

  @override
  Future<String?> getLibraryPath() async => kLibraryPath;

  @override
  Future<String?> getApplicationDocumentsPath() async =>
      kApplicationDocumentsPath;

  @override
  Future<String?> getExternalStoragePath() async => kExternalStoragePath;

  @override
  Future<List<String>?> getExternalCachePaths() async =>
      <String>[kExternalCachePath];

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async =>
      <String>[kExternalStoragePath];

  @override
  Future<String?> getDownloadsPath() async => kDownloadsPath;
}
