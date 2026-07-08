import 'package:flutter_skin/flutter_skin.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Initialization test across different scenarios', () {
    test(
      'should throw an exception if init is called with an empty apiKey',
      () async {
        expect(
          () => FlutterSkin.init(apiKey: ''),
          throwsA(isA<ArgumentError>()),
        );
      },
    );

    test(
      'should throw an exception if init is called with an invalid apiKey',
      () async {
        expect(
          () => FlutterSkin.init(apiKey: 'my_api_key'),
          throwsA(isA<ArgumentError>()),
        );
      },
    );

    test('should throw an exception if singleton is accessed before init', () {
      expect(() => FlutterSkin.singleton, throwsA(isA<Exception>()));
    });

    test('should throw an exception if theme is accessed before init', () {
      expect(() => FlutterSkin.theme, throwsA(isA<Exception>()));
    });
  });
}
