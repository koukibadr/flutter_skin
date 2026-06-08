import 'package:flutter/material.dart';
import 'package:flutter_skin/extensions/color_extensions.dart';
import 'package:flutter_skin/mock_skin.dart';
import 'package:flutter_skin/models/skin_model.dart' hide Colors;
import 'package:flutter_skin/remote/fskin_remote_config.dart';

class FlutterSkin {
  final String apiKey;
  final String projectName;

  FskinRemoteConfig remoteConfig = FskinRemoteConfig.instance;

  FlutterSkin.init({required this.apiKey, required this.projectName}) {
    remoteConfig.fetchConfig(); // Fetch the initial configuration values
  }

  static ThemeData toThemeData() {
    SkinModel skinModel = SkinModel.fromMap(mockSkin);
    Color primaryColor = skinModel.colors.primary != null
        ? skinModel.colors.primary!.toHexColor()
        : Colors.blue;
    return ThemeData(
      primaryColor: primaryColor,
    );
  }
}
