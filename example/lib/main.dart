import 'package:material_ui/material_ui.dart';
import 'package:flutter_skin/flutter_skin.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterSkin.init(
    apiKey:
        "fsk_64f065739f185e339674daa9108ab390c9f7f758cb7d2579c72bb4e7d70ca7db",
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
