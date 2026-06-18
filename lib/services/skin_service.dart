import 'dart:convert';

import 'package:flutter_skin/models/project_config.dart';
import 'package:http/http.dart' as http;

class SkinService {
  static final SkinService _instance = SkinService._();

  SkinService._();

  factory SkinService() {
    return _instance;
  }

  Future<ProjectConfig?> fetchData(String apiKey) async {
    try {
      var client = http.Client();
      var response = await client.post(
        Uri.https('fskin-backend.vercel.app', 'fskin/skin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'apiKey': apiKey}),
      );
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      var projectConfig = ProjectConfig.fromMap(decodedResponse);
      return projectConfig;
    } catch (e) {
      return null;
    }
  }
}
