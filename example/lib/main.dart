import 'package:flutter/material.dart';
import 'package:flutter_skin/flutter_skin.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterSkin.init(
    developerId: '4cd76c05-0e47-49cc-a514-33eb1049b674',
    projectId: '2735b07a-fea8-451a-b61d-96ec72d29be8',
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

