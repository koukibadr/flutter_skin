import 'package:flutter_skin/models/project_config.dart';
import 'package:flutter_skin/services/skin_service.dart';
import 'package:flutter_skin/services/supabase_client.dart';

class FskinRemoteConfig {

  static FskinRemoteConfig? _instance;

  late String developerId;
  late String projectId;
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
  static Future<FskinRemoteConfig> init({
    required String developerId,
    required String projectId,
  }) async {
    _instance ??= FskinRemoteConfig._();
    _instance!.developerId = developerId;
    _instance!.projectId = projectId;
    await _instance!._initializeConfig();
    return _instance!;
  }

  Future<void> _initializeConfig() async {
    // Initialize Supabase and fetch config in background
    await SupabaseClient.initialize();
    await fetchConfig();
  }

  Future<void> fetchConfig() async {
    // Call the skin service to fetch skin for developer and project
    final skin = await SkinService().getSkin(developerId, projectId);
    _cachedConfig = ProjectConfig(
      skin: skin,
      projectName: projectId,
    );
  }
}