import 'package:flutter/material.dart';
import 'package:social_media_app/auth/login_page.dart';
import 'package:social_media_app/auth/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
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
        scaffoldBackgroundColor: const Color(0xff222222),
        brightness: Brightness.light,
        primarySwatch: Colors.grey,
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white
          )
        )
      ),
      home: const  AuthPage(),
    );
  }
}

