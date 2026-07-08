import 'package:flutter/material.dart';
import 'package:flutter_skin/flutter_skin.dart';
import 'package:flutter_skin/models/project_config.dart';
import 'package:flutter_skin/remote/fskin_remote_config.dart';
import 'package:flutter_skin/services/skin_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/skin_model_mocks.dart';

class MockFskinRemoteConfig extends Mock implements FskinRemoteConfig {}

class MockProjectConfig extends Mock implements ProjectConfig {}

class MockSkinService extends Mock implements SkinService {}

void main() async {
  group('FlutterSkin Initialization Tests', () {
    final apiKey =
        'fsk_1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef';

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      FlutterSkin.resetInstance();
      await FlutterSkin.init(
        apiKey: apiKey,
        remoteConfig: MockFskinRemoteConfig(),
      );
    });

    test('Checking FlutterSkin initialization with fake API key', () async {
      final skin = FlutterSkin.theme;
      final instance = FlutterSkin.singleton;

      expect(instance.apiKey, apiKey);
      expect(skin, null);
    });

    test('Veryfing skin model initalization with remote config', () async {
      final instance = FlutterSkin.singleton;

      when(
        () => FlutterSkin.remoteConfig.projectConfig,
      ).thenAnswer((_) => ProjectConfig(skin: skinModelMock));

      final skin = FlutterSkin.theme;
      expect(instance.apiKey, apiKey);
      expect(skin, isA<ThemeData>());
      expect(skin?.colorScheme.primary, skinModelMock.colors?.primary);
    });

    test('project config returns a nullable skin', () async {
      final instance = FlutterSkin.singleton;
      when(
        () => FlutterSkin.remoteConfig.projectConfig,
      ).thenAnswer((_) => MockProjectConfig());

      var skin = FlutterSkin.theme;
      expect(instance.apiKey, apiKey);
      expect(skin, isA<Null>());

      skin = FlutterSkin.toThemeData(
        fallbackTheme: ThemeData(primaryColor: Colors.red),
      );
      expect(skin, isA<ThemeData>());
      expect(skin?.brightness, Brightness.light);
    });
  });
}
