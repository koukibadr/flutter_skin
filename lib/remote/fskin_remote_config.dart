import 'package:flutter_skin/models/project_config.dart';
import 'package:flutter_skin/services/skin_service.dart';

class FskinRemoteConfig {
  static FskinRemoteConfig? _instance;

  late String apiKey;
  ProjectConfig? _cachedConfig;

  static ProjectConfig? get projectConfig {
    if (_instance == null) {
      throw Exception(
        'FskinRemoteConfig must be initialized with FskinRemoteConfig.init()',
      );
    }
    return _instance!._cachedConfig;
  }

  // Private constructor
  FskinRemoteConfig._();

  static FskinRemoteConfig get singleton {
    if (_instance == null) {
      throw Exception(
        'FskinRemoteConfig must be initialized with FskinRemoteConfig.init()',
      );
    }
    return _instance!;
  }

  // Factory method to initialize and get the singleton instance
  static Future<FskinRemoteConfig> init({required String apiKey}) async {
    _instance ??= FskinRemoteConfig._();
    _instance!.apiKey = apiKey;
    await _instance!.fetchConfig();
    return _instance!;
  }

  Future<void> fetchConfig() async {
    // Call the skin service to fetch skin for developer and project
    //final skin = await SkinService().getSkin(apiKey);
    _cachedConfig = await SkinService().fetchData(apiKey);
  }
}
