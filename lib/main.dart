import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news_app/dashboard.dart';
import 'package:flutter_news_app/index.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '今日头条',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Dashboard()
      },
    );
  }
}

