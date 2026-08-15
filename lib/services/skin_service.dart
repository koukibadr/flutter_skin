import 'dart:convert';

import 'package:flutter_skin/constants/fskin_constants.dart';
import 'package:flutter_skin/models/project_config.dart';
import 'package:flutter_skin/services/cache_service.dart';
import 'package:flutter_skin/services/fskin_logger.dart';
import 'package:http/http.dart' as http;

/// Singleton service class responsible for fetching the skin configuration from the remote server.
/// This class abstracts the network communication and provides a method to retrieve the ProjectConfig
class SkinService {
  static final SkinService _instance = SkinService._();
  final FskinLogger _logger = FskinLogger();
  final CacheService _cacheService = CacheService();

  SkinService._();

  factory SkinService() {
    return _instance;
  }

  Future<ProjectConfig?> fetchData() async {
    _logger.logMessage('Fetching skin configuration for the provided apiKey.');
    var client = http.Client();
    try {
      final apiKey = await _cacheService.getApiKey();
      var response = await client
          .post(
            Uri.https(FskinConstants.baseUrl, 'fskin/skin'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'apiKey': apiKey}),
          )
          .timeout(const Duration(seconds: 5));

      _logger.logMessage(
        'Received response with status code: ${response.statusCode}',
      );
      if (response.statusCode != 200) {
        _logger.logError(
          'Error fetching skin configuration: ${response.statusCode}',
          errorObject: response,
        );
        return null;
      }

      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      var projectConfig = ProjectConfig.fromMap(decodedResponse);
      _cacheService.saveProjectConfig(decodedResponse);
      return projectConfig;
    } catch (e) {
      _logger.logError('Error fetching skin configuration: $e', errorObject: e);

      final savedProjectConfig = await _cacheService.getProjectConfig();
      final savedLastUpdated = await _cacheService.getLastUpdated();

      if (savedProjectConfig != null && savedLastUpdated != null) {
        final currentTime = DateTime.now();
        final difference = currentTime.difference(savedLastUpdated);
        // If the cached data is less than or equal to 3 days old, return the cached configuration
        if (difference.inDays <= 3) {
          _logger.logMessage(
            'Using cached skin configuration. Last updated: $savedLastUpdated',
          );
          return savedProjectConfig;
        }
      }

      return null;
    } finally {
      client.close();
    }
  }
}
