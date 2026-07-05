import 'dart:convert';

import 'package:flutter_skin/constants/fskin_constants.dart';
import 'package:flutter_skin/models/project_config.dart';
import 'package:flutter_skin/services/fskin_logger.dart';
import 'package:http/http.dart' as http;

/// Singleton service class responsible for fetching the skin configuration from the remote server.
/// This class abstracts the network communication and provides a method to retrieve the ProjectConfig
class SkinService {
  static final SkinService _instance = SkinService._();
  final FskinLogger _logger = FskinLogger();

  SkinService._();

  factory SkinService() {
    return _instance;
  }

  Future<ProjectConfig?> fetchData(String apiKey) async {
    _logger.logMessage('Fetching skin configuration for the provided apiKey.');
    var client = http.Client();
    try {
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
      return ProjectConfig.fromMap(decodedResponse);
    } catch (e) {
      _logger.logError('Error fetching skin configuration: $e', errorObject: e);
      return null;
    } finally {
      client.close();
    }
  }
}
