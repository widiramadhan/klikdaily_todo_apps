import 'package:apps_todo/helper/locator.dart';
import 'package:apps_todo/view/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Apps',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(body1: TextStyle(fontSize: 12), body2: TextStyle(fontSize: 12)),
        fontFamily: 'DMSans',
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      supportedLocales: const <Locale>[
        Locale('en', ''),
        Locale('ar', ''),
      ],
      home: HomeView(),
    );
  }
}
