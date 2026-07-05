import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter_skin/constants/fskin_constants.dart';
import 'package:flutter_skin/services/fskin_logger.dart';
import 'package:http/http.dart' as http;

class FskinSubscriber {
  StreamSubscription? _subscription;
  late http.Client _client;
  int _retryCount = 0;
  bool _disposed = false;
  final FskinLogger _logger = FskinLogger();

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
                    _logger.logMessage('Skin update event received.');
                    onSkinUpdated();
                  }
                },
                onDone: () {
                  _logger.logMessage('Stream connection closed. Retrying...');
                  _retry(apiKey, baseUrl, onSkinUpdated);
                },
                onError: (e) {
                  _logger.logError(
                    'Stream connection error. Retrying...',
                    errorObject: e,
                  );
                  _retry(apiKey, baseUrl, onSkinUpdated);
                },
              );
        })
        .catchError((e) {
          _logger.logError(
            'Stream connection error. Retrying...',
            errorObject: e,
          );
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
    _logger.logMessage(
      'Disposing FskinSubscriber and closing stream connection.',
    );
    _disposed = true;
    _subscription?.cancel();
    _client.close();
  }
}
