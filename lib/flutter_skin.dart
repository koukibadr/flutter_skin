import 'package:flutter/material.dart';
import 'package:flutter_skin/extensions/color_extensions.dart';
import 'package:flutter_skin/mock_skin.dart';
import 'package:flutter_skin/models/project_config.dart';
import 'package:flutter_skin/models/skin_model.dart' hide Colors;
import 'package:flutter_skin/remote/fskin_remote_config.dart';

class FlutterSkin {
  static FlutterSkin? _instance;

  late String apiKey;
  late String projectName;

  // Private constructor
  FlutterSkin._();

  // Factory method to initialize and get the singleton instance
  factory FlutterSkin.init({
    required String apiKey,
    required String projectName,
  }) {
    _instance ??= FlutterSkin._();
    _instance!.apiKey = apiKey;
    _instance!.projectName = projectName;

    final remoteConfig = FskinRemoteConfig.init(
      apiKey: apiKey,
      projectName: projectName,
    );
    remoteConfig.fetchConfig();

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
    Color? primaryColor = config?.skinModel.colors.primary!.toHexColor();
    ThemeData remoteTheme = ThemeData(primaryColor: primaryColor);
    if (primaryColor == null) {
      if (fallbackTheme != null) {
        return fallbackTheme;
      }
    } else {
      return remoteTheme;
    }
    return null;
  }
}
