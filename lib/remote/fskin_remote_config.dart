import 'package:flutter_skin/mock_skin.dart';
import 'package:flutter_skin/models/project_config.dart';
import 'package:flutter_skin/models/skin_model.dart';

class FskinRemoteConfig {

  static FskinRemoteConfig? _instance;

  late String apiKey;
  late String projectName;
  ProjectConfig? _cachedConfig;

  static ProjectConfig? get projectConfig {
    if (_instance == null) {
      throw Exception('FskinRemoteConfig must be initialized with FskinRemoteConfig.init()');
    }
    return _instance!._cachedConfig;
  }

  // Private constructor
  FskinRemoteConfig._();


  static FskinRemoteConfig get singleton {
    if (_instance == null) {
      throw Exception('FskinRemoteConfig must be initialized with FskinRemoteConfig.init()');
    }
    return _instance!;
  }

  // Factory method to initialize and get the singleton instance
  factory FskinRemoteConfig.init(
      {required String apiKey, required String projectName}) {
    _instance ??= FskinRemoteConfig._();
    _instance!.apiKey = apiKey;
    _instance!.projectName = projectName;
    _instance!.fetchConfig();
    return _instance!;
  }

  Future<void> fetchConfig() async {
    // Fetch the value for the given key from the remote configuration
    // You can implement the logic to retrieve the value from your server or local cache
    _cachedConfig = ProjectConfig(skinModel: SkinModel.fromMap(mockSkin), projectName: projectName); // Return a default value if the key is not found;
  }

}