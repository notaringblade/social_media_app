import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {


    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "FriendsPage",
            style: TextStyle(color: Colors.white),
          ),

        ],
      ),
    );
  }
}
