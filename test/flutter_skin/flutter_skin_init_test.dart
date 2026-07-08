import 'package:flutter/material.dart';
import 'package:flutter_skin/flutter_skin.dart';
import 'package:flutter_skin/models/project_config.dart';
import 'package:flutter_skin/remote/fskin_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/skin_model_mocks.dart';

class MockFskinRemoteConfig extends Mock implements FskinRemoteConfig {}

class MockProjectConfig extends Mock implements ProjectConfig {}

void main() async {
  group('FlutterSkin Initialization Tests', () {
    final apiKey =
        'fsk_1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef';

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await FlutterSkin.init(apiKey: apiKey);
    });

    test('fetches and applies skin on successful response', () async {
      // Testing with fake api key will result in null theme.
      await FlutterSkin.init(apiKey: apiKey);

      final skin = FlutterSkin.theme;
      final instance = FlutterSkin.singleton;

      expect(instance.apiKey, apiKey);
      expect(skin, null);
    });

    test('applies skin from remote config', () async {
      final instance = FlutterSkin.singleton;

      instance.setRemoteConfig(MockFskinRemoteConfig());
      when(
        FlutterSkin.remoteConfig.projectConfig,
      ).thenReturn(ProjectConfig(skin: skinModelMock));

      final skin = FlutterSkin.theme;
      expect(instance.apiKey, apiKey);
      expect(skin, isA<ThemeData>());
      expect(skin?.colorScheme.primary, skinModelMock.colors?.primary);
    });

    test('project config returns a nullable skin', () async {
      final instance = FlutterSkin.singleton;

      instance.setRemoteConfig(MockFskinRemoteConfig());
      when(
        FlutterSkin.remoteConfig.projectConfig,
      ).thenReturn(MockProjectConfig());

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
