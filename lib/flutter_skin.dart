import 'package:flutter/material.dart';
import 'package:flutter_skin/models/project_config.dart';
import 'package:flutter_skin/remote/fskin_remote_config.dart';

class FlutterSkin {
  static FlutterSkin? _instance;

  late String apiKey;

  // Private constructor
  FlutterSkin._();

  // Factory method to initialize and get the singleton instance
  static Future<FlutterSkin> init({required String apiKey}) async {
    if (apiKey.trim().isEmpty) {
      throw ArgumentError.value(apiKey, 'apiKey', 'apiKey must not be empty');
    }
    _instance ??= FlutterSkin._();
    _instance!.apiKey = apiKey;

    await FskinRemoteConfig.init(apiKey: apiKey);

    return _instance!;
  }

  static FlutterSkin get singleton {
    if (_instance == null) {
      throw Exception(
        'FlutterSkin must be initialized with FlutterSkin.init()',
      );
    }
    return _instance!;
  }

  static ThemeData? toThemeData({ThemeData? fallbackTheme}) {
    ProjectConfig? config = FskinRemoteConfig.projectConfig;
    ColorScheme? colors = config?.skin?.colors;
    ThemeData remoteTheme = ThemeData(colorScheme: colors);
    if (colors == null) {
      if (fallbackTheme != null) {
        return fallbackTheme;
      }
    } else {
      return remoteTheme;
    }
    return null;
  }

  /// Query current active theme from remote config and return as ThemeData.
  /// When there's no active theme, the result is null.
  static ThemeData? get theme {
    return toThemeData();
  }
}
