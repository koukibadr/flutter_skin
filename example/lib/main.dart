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
  ThemeMode _themeMode = ThemeMode.dark;

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
      theme: FlutterSkin.toThemeData(fallbackTheme: ThemeData.light()),
      darkTheme: FlutterSkin.darkTheme(fallbackTheme: ThemeData.dark()),
      themeMode: _themeMode,
      home: MyHomePage(
        title: 'Movie Browser',
        themeMode: _themeMode,
        onThemeModeChanged: (themeMode) {
          setState(() {
            _themeMode = themeMode;
          });
        },
      ),
    );
  }
}
