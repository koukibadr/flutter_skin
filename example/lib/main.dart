import 'package:flutter/material.dart';
import 'package:flutter_skin/flutter_skin.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterSkin.init(
    apiKey:
        "fsk_ca8f01785a2bac063eb06d8895c76e021e18554af328248d8e2ab0d0a96f0cdc",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: FlutterSkin.toThemeData(),
      home: const MyHomePage(title: 'Movie Browser'),
    );
  }
}
