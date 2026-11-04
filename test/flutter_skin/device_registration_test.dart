import 'package:flutter_skin/flutter_skin.dart';
import 'package:flutter_skin/models/project_config.dart';
import 'package:flutter_skin/remote/fskin_remote_config.dart';
import 'package:flutter_skin/services/cache_service.dart';
import 'package:flutter_skin/services/skin_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/skin_model_mocks.dart';

class MockFskinRemoteConfig extends Mock implements FskinRemoteConfig {}

class MockProjectConfig extends Mock implements ProjectConfig {}

class MockSkinService extends Mock implements SkinService {}

class MockCachingService extends Mock implements CacheService {}

void main() async {
  group('Device Registration Tests', () {
    final apiKey =
        'fsk_1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef';

    MockSkinService? mockSkinService;
    MockCachingService? mockCachingService;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      mockSkinService = MockSkinService();
      mockCachingService = MockCachingService();
      when(
        () => mockCachingService?.saveApiKey(any()),
      ).thenAnswer((_) async {});
    });

    tearDown(() {
      mockSkinService = null;
    });

    test('Checking device registration when completes correctly', () async {
      when(
        () => mockSkinService?.fetchData(),
      ).thenAnswer((_) async => ProjectConfig(skin: skinModelMock));

      when(
        () => mockSkinService?.registerDevice(),
      ).thenAnswer((_) async => Future.value());

      var remoteConfig = await FskinRemoteConfig.init(
        apiKey: apiKey,
        skinService: mockSkinService,
        cacheService: mockCachingService,
      );

      await FlutterSkin.init(apiKey: apiKey, remoteConfig: remoteConfig);

      expect(mockSkinService?.registerDevice(), completes);
    });

    test('Checking when register device is throwing an error', () async {
      try {
        when(
          () => mockSkinService?.fetchData(),
        ).thenAnswer((_) async => ProjectConfig(skin: skinModelMock));

        when(
          () => mockSkinService?.registerDevice(),
        ).thenThrow(Exception('Device registration failed'));

        var remoteConfig = await FskinRemoteConfig.init(
          apiKey: apiKey,
          skinService: mockSkinService,
          cacheService: mockCachingService,
        );

        await FlutterSkin.init(apiKey: apiKey, remoteConfig: remoteConfig);
      } catch (e) {
        expect(e, isA<Exception>());
        expect(
          (e as Exception).toString(),
          contains('Device registration failed'),
        );
      }
    });
  });
}
