import 'package:flutter/material.dart';
import 'package:flutter_skin/flutter_skin.dart';
import 'package:flutter_skin/models/project_config.dart';
import 'package:flutter_skin/remote/fskin_remote_config.dart';
import 'package:flutter_skin/services/skin_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/skin_model_mocks.dart';

class MockSkinService extends Mock implements SkinService {}

void main() {
  group('FlutterSkin: Verify FlutterService Integration', () {
    final apiKey =
        'fsk_1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef';

    MockSkinService? mockSkinService;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      FlutterSkin.resetInstance();
      FskinRemoteConfig.resetInstance();
      mockSkinService = MockSkinService();
    });

    test('Verifying Service returning valid skin theme data', () async {
      when(
        () => mockSkinService?.fetchData(apiKey),
      ).thenAnswer((_) async => ProjectConfig(skin: skinModelMock));

      var remoteConfig = await FskinRemoteConfig.init(
        apiKey: apiKey,
        skinService: mockSkinService,
      );

      await FlutterSkin.init(apiKey: apiKey, remoteConfig: remoteConfig);
      final fskinInstance = FlutterSkin.singleton;

      final skin = FlutterSkin.theme;
      expect(fskinInstance.apiKey, apiKey);
      expect(skin, isA<ThemeData>());
      expect(skin?.colorScheme.primary, skinModelMock.colors?.primary);
    });

    test('Verifying Service returning null skin theme data', () async {
      when(
        () => mockSkinService?.fetchData(apiKey),
      ).thenAnswer((_) async => ProjectConfig(skin: null));

      var remoteConfig = await FskinRemoteConfig.init(
        apiKey: apiKey,
        skinService: mockSkinService,
      );

      await FlutterSkin.init(apiKey: apiKey, remoteConfig: remoteConfig);
      final fskinInstance = FlutterSkin.singleton;

      final skin = FlutterSkin.theme;
      expect(fskinInstance.apiKey, apiKey);
      expect(skin, isA<Null>());
      expect(skin?.colorScheme.primary, isNull);
    });

    test(
      'Verifying Service returning null skin value with fallback theme data',
      () async {
        when(
          () => mockSkinService?.fetchData(apiKey),
        ).thenAnswer((_) async => ProjectConfig(skin: null));

        var remoteConfig = await FskinRemoteConfig.init(
          apiKey: apiKey,
          skinService: mockSkinService,
        );

        await FlutterSkin.init(apiKey: apiKey, remoteConfig: remoteConfig);
        final fskinInstance = FlutterSkin.singleton;

        final skin = FlutterSkin.toThemeData(
          fallbackTheme: ThemeData(
            colorScheme: ColorScheme.light(primary: Colors.red),
          ),
        );
        expect(fskinInstance.apiKey, apiKey);
        expect(skin, isA<ThemeData>());
        expect(skin?.colorScheme.primary, Colors.red);
      },
    );

    test(
      'Verifying Service returning valid skin data with fallback theme data',
      () async {
        when(
          () => mockSkinService?.fetchData(apiKey),
        ).thenAnswer((_) async => ProjectConfig(skin: skinModelMock));

        var remoteConfig = await FskinRemoteConfig.init(
          apiKey: apiKey,
          skinService: mockSkinService,
        );

        await FlutterSkin.init(apiKey: apiKey, remoteConfig: remoteConfig);
        final fskinInstance = FlutterSkin.singleton;

        final skin = FlutterSkin.toThemeData(
          fallbackTheme: ThemeData(
            colorScheme: ColorScheme.light(primary: Colors.red),
          ),
        );
        expect(fskinInstance.apiKey, apiKey);
        expect(skin, isA<ThemeData>());
        expect(skin?.colorScheme.primary, skinModelMock.colors?.primary);
      },
    );
  });
}
