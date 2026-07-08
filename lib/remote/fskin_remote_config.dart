import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_skin/models/project_config.dart';
import 'package:flutter_skin/services/skin_service.dart';

/// Singleton class responsible for managing the remote configuration of the skin.
/// It fetches the configuration from the remote server using the provided API key and caches it for
/// subsequent access.
class FskinRemoteConfig {
  static FskinRemoteConfig? _instance;
  static final StreamController<ThemeData> _skinController =
      StreamController<ThemeData>.broadcast();

  late String apiKey;
  ProjectConfig? _cachedConfig;

  Stream<ThemeData> get onSkinChanged => _skinController.stream;

  ProjectConfig? get projectConfig {
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
    _skinController.add(ThemeData(colorScheme: _cachedConfig?.skin?.colors));
  }
}
