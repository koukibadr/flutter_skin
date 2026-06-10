import 'package:flutter/material.dart';
import 'package:flutter_skin/extensions/color_extensions.dart';
import 'package:flutter_skin/models/project_config.dart';
import 'package:flutter_skin/models/skin_model.dart';
import 'package:flutter_skin/remote/fskin_remote_config.dart';

class FlutterSkin {
  static FlutterSkin? _instance;

  late String developerId;
  late String projectId;

  // Private constructor
  FlutterSkin._();

  // Factory method to initialize and get the singleton instance
  static Future<FlutterSkin> init({
    required String developerId,
    required String projectId,
  }) async {
    _instance ??= FlutterSkin._();
    _instance!.developerId = developerId;
    _instance!.projectId = projectId;

    await FskinRemoteConfig.init(
      developerId: developerId,
      projectId: projectId,
    );

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
    ColorScheme? colors = config?.skinModel.colors;
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
}
