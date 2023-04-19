import 'package:flutter/material.dart';
import 'package:social_media_app/auth/login_page.dart';
import 'package:social_media_app/auth/register_page.dart';

class LoginOrSignUp extends StatefulWidget {
  const LoginOrSignUp({Key? key}) : super(key: key);

  @override
  LoginOrSignUpState createState() => LoginOrSignUpState();
}

class LoginOrSignUpState extends State<LoginOrSignUp> {
  bool isLogin = true;

  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LoginPage(onTap: toggle);
    } else {
      return RegisterPage(onTap:toggle,);
    }
  }
}
