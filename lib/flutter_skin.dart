import 'package:flutter/material.dart' show ThemeData, ColorScheme;
import 'package:flutter/widgets.dart';
import 'package:flutter_skin/models/project_config.dart';
import 'package:flutter_skin/remote/fskin_remote_config.dart';
import 'package:flutter_skin/services/fskin_logger.dart';
import 'package:flutter_skin/services/fskin_subscriber.dart';

class FlutterSkin with WidgetsBindingObserver {
  static FlutterSkin? _instance;

  late String apiKey;
  static final FskinSubscriber _sse = FskinSubscriber();
  static Stream<ThemeData> get onSkinChanged => FskinRemoteConfig.onSkinChanged;
  static final FskinLogger _logger = FskinLogger();

  // Private constructor
  FlutterSkin._();

  static Future<FlutterSkin> init({required String apiKey}) async {
    if (apiKey.trim().isEmpty) {
      _logger.logError('apiKey must not be empty');
      throw ArgumentError.value(apiKey, 'apiKey', 'apiKey must not be empty');
    }
    if (_instance == null) {
      _instance = FlutterSkin._();
      WidgetsBinding.instance.addObserver(_instance!);
    }
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

  /// Start listening to the backend stream for skin and projects updates
  static void _startStream() {
    _logger.logMessage(
      'Starting stream connection to listen for skin updates.',
    );
    _sse.listen(
      apiKey: _instance!.apiKey,
      onSkinUpdated: FskinRemoteConfig.singleton.fetchConfig,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // When the app is resumed, fetch the latest config and restart the stream.
    if (state == AppLifecycleState.resumed) {
      try {
        _logger.logMessage('Fetching latest config and restarting stream.');
        await FskinRemoteConfig.singleton.fetchConfig();
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
    ProjectConfig? config = FskinRemoteConfig.projectConfig;
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
    return toThemeData();
  }
}
