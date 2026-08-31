import 'package:material_ui/material_ui.dart';
import 'package:flutter_skin/flutter_skin.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterSkin.init(
    apiKey:
        "fsk_6de8ab29a783fbbe8269804e6c581d2f83060ad6b50f8b056983440730300a05",
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
