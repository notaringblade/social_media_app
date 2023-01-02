import 'package:flutter/material.dart';
import 'package:social_media_app/main_pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.black,
        brightness: Brightness.light,
        primarySwatch: Colors.green,
      ),
      home: const MainPage(),
    );
  }
}

