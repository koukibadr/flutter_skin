import 'package:flutter/material.dart';
import 'package:flutter_skin/flutter_skin.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterSkin.init(
    apiKey:
        "fsk_b0ce429cfbded17bbca66eef6e68bd1f0b7fbf9d74be0c3a0ac8b2e0554b7919",
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FlutterSkin.onSkinChanged.listen((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: FlutterSkin.toThemeData(),
      home: const MyHomePage(title: 'Movie Browser'),
    );
  }
}
