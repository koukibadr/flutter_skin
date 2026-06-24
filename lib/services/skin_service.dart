import 'dart:convert';

import 'package:flutter_skin/constants/fskin_constants.dart';
import 'package:flutter_skin/models/project_config.dart';
import 'package:http/http.dart' as http;

/// Singleton service class responsible for fetching the skin configuration from the remote server.
/// This class abstracts the network communication and provides a method to retrieve the ProjectConfig
class SkinService {
  static final SkinService _instance = SkinService._();

  SkinService._();

  factory SkinService() {
    return _instance;
  }

  Future<ProjectConfig?> fetchData(String apiKey) async {
    var client = http.Client();
    try {
      var response = await client
          .post(
            Uri.https(FskinConstants.baseUrl, 'fskin/skin'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'apiKey': apiKey}),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        return null;
      }

      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      return ProjectConfig.fromMap(decodedResponse);
    } catch (e) {
      return null;
    } finally {
      client.close();
    }
  }
}
