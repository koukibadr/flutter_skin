import 'package:flutter/material.dart';
import 'package:flutter_skin/flutter_skin.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterSkin.init(
    developerId: '327da410-9f8b-4160-bebb-6dde31f26cef',
    projectId: 'a195c32f-eb4a-4b6a-a748-575374945255',
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

