import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter_skin/constants/fskin_constants.dart';
import 'package:http/http.dart' as http;

class FskinSubscriber {
  StreamSubscription? _subscription;
  late http.Client _client;
  int _retryCount = 0;
  bool _disposed = false;

  void listen({required String apiKey, required VoidCallback onSkinUpdated}) {
    _disposed = false;
    _client = http.Client();
    _connect(apiKey, FskinConstants.baseUrl, onSkinUpdated);
  }

  void _connect(String apiKey, String baseUrl, VoidCallback onSkinUpdated) {
    if (_disposed) return;

    final request = http.Request(
      'GET',
      Uri.parse('https://$baseUrl/fskin/stream?apiKey=$apiKey'),
    );

    _client
        .send(request)
        .then((response) {
          _retryCount = 0;
          _subscription = response.stream
              .transform(utf8.decoder)
              .transform(const LineSplitter())
              .listen(
                (line) {
                  if (line.startsWith('event: skin_updated') ||
                      line.startsWith('event: project_updated')) {
                    onSkinUpdated();
                  }
                },
                onDone: () {
                  _retry(apiKey, baseUrl, onSkinUpdated);
                },
                onError: (_) {
                  _retry(apiKey, baseUrl, onSkinUpdated);
                },
              );
        })
        .catchError((_) {
          _retry(apiKey, baseUrl, onSkinUpdated);
        });
  }

  void _retry(String apiKey, String baseUrl, VoidCallback onSkinUpdated) {
    if (_disposed) return;
    _retryCount++;
    final seconds = (_retryCount * 2).clamp(2, 30);
    Future.delayed(
      Duration(seconds: seconds),
      () => _connect(apiKey, baseUrl, onSkinUpdated),
    );
  }

  void dispose() {
    _disposed = true;
    _subscription?.cancel();
    _client.close();
  }
}
