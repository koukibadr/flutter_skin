import 'dart:convert';

import 'package:flutter_skin/models/project_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static final CacheService _instance = CacheService._();

  CacheService._();

  factory CacheService() {
    return _instance;
  }

  final sharedPreferences = SharedPreferences.getInstance();

  Future<void> saveApiKey(String apiKey) async {
    final prefs = await sharedPreferences;
    await prefs.setString('apiKey', apiKey);
  }

  Future<String?> getApiKey() async {
    final prefs = await sharedPreferences;
    return prefs.getString('apiKey');
  }

  Future<void> saveProjectConfig(Map<String, dynamic> projectConfig) async {
    final prefs = await sharedPreferences;
    await prefs.setString('projectConfig', jsonEncode(projectConfig));
    await prefs.setString('lastUpdated', DateTime.now().toIso8601String());
  }

  Future<ProjectConfig?> getProjectConfig() async {
    final prefs = await sharedPreferences;
    final projectConfigString = prefs.getString('projectConfig');

    if (projectConfigString != null) {
      final Map<String, dynamic> projectConfig =
          jsonDecode(projectConfigString) as Map<String, dynamic>;
      return ProjectConfig.fromMap(projectConfig);
    }
    return null;
  }

  Future<DateTime?> getLastUpdated() async {
    final prefs = await sharedPreferences;
    final value = prefs.getString('lastUpdated');
    return value != null ? DateTime.parse(value) : null;
  }
}
