import 'package:flutter/material.dart' show ThemeData, ColorScheme;
import 'package:flutter/widgets.dart';
import 'package:flutter_skin/constants/fskin_constants.dart';
import 'package:flutter_skin/models/project_config.dart';
import 'package:flutter_skin/remote/fskin_remote_config.dart';
import 'package:flutter_skin/services/fskin_logger.dart';
import 'package:flutter_skin/services/fskin_subscriber.dart';

class FlutterSkin with WidgetsBindingObserver {
  static FlutterSkin? _instance;

  late String apiKey;
  static final FskinSubscriber _sse = FskinSubscriber();
  static FskinRemoteConfig remoteConfig = FskinRemoteConfig.singleton;
  static Stream<ThemeData> get onSkinChanged => remoteConfig.onSkinChanged;
  static final FskinLogger _logger = FskinLogger();

  // Private constructor
  FlutterSkin._();

  static Future<FlutterSkin> init({
    required String apiKey,
    @visibleForTesting FskinRemoteConfig? remoteConfig,
  }) async {
    if (apiKey.trim().isEmpty) {
      _logger.logError('apiKey must not be empty');
      throw ArgumentError.value(apiKey, 'apiKey', 'apiKey must not be empty');
    } else if (RegExp(FskinConstants.keyRegex).hasMatch(apiKey) == false) {
      _logger.logError('apiKey is not valid');
      throw ArgumentError.value(apiKey, 'apiKey', 'apiKey is not valid');
    }

    if (_instance == null) {
      _instance = FlutterSkin._();
      WidgetsBinding.instance.addObserver(_instance!);
    }
    _instance!.apiKey = apiKey;

    if (remoteConfig != null) {
      FlutterSkin.remoteConfig = remoteConfig;
    } else {
      FlutterSkin.remoteConfig = await FskinRemoteConfig.init(apiKey: apiKey);
    }

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

  /// Start listening to the backend stream for skin and projects updates
  static void _startStream() {
    _logger.logMessage(
      'Starting stream connection to listen for skin updates.',
    );
    _sse.listen(
      apiKey: _instance!.apiKey,
      onSkinUpdated: remoteConfig.fetchConfig,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // When the app is resumed, fetch the latest config and restart the stream.
    if (state == AppLifecycleState.resumed) {
      try {
        _logger.logMessage('Fetching latest config and restarting stream.');
        await remoteConfig.fetchConfig();
      } finally {
        _startStream();
      }

      // When the app is paused, dispose the stream to save resources.
    } else if (state == AppLifecycleState.paused) {
      _logger.logMessage('Disposing stream to save resources.');
      _sse.dispose();
    }
  }

  /// Query current active theme from remote config and return as ThemeData.
  /// When there's no active theme, the result is null or fallbackTheme if provided.
  static ThemeData? toThemeData({ThemeData? fallbackTheme}) {
    ProjectConfig? config = remoteConfig.projectConfig;
    ColorScheme? colors = config?.skin?.colors;
    ThemeData remoteTheme = ThemeData(colorScheme: colors);
    if (colors == null) {
      if (fallbackTheme != null) {
        _logger.logWarning('No active theme found. Returning fallback theme.');
        return fallbackTheme;
      }
    } else {
      _logger.logMessage('Active theme found. Returning remote theme.');
      return remoteTheme;
    }
    return null;
  }

  /// Query current active theme from remote config and return as ThemeData.
  /// When there's no active theme, the result is null.
  static ThemeData? get theme {
    if (_instance == null) {
      throw Exception(
        'FlutterSkin must be initialized with FlutterSkin.init()',
      );
    }
    return toThemeData();
  }

  @visibleForTesting
  static void resetInstance() {
    _instance = null;
  }
}
