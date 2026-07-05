import 'dart:developer';

class FskinLogger {
  static final FskinLogger _instance = FskinLogger._();

  FskinLogger._();

  factory FskinLogger() {
    return _instance;
  }

  void logMessage(String message) {
    log(
      'Fskin: $message',
      level: 800,
      time: DateTime.now(),
      name: 'FskinLogger',
    );
  }

  void logError(String error, {Object? errorObject}) {
    log(
      'Fskin Error: $error',
      level: 1000,
      time: DateTime.now(),
      name: 'FskinLogger',
      error: errorObject,
    );
  }

  void logWarning(String warning) {
    log(
      'Fskin Warning: $warning',
      level: 900,
      time: DateTime.now(),
      name: 'FskinLogger',
    );
  }
}
