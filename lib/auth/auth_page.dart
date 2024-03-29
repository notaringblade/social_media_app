import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/auth/login_or_sign_up.dart';
import 'package:social_media_app/main_pages/main_page.dart';

class AuthPage extends StatelessWidget {
const AuthPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges() ,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return const MainPage();
          }else{
            return const LoginOrSignUp();
          }
        },
      )
    );
  }
}