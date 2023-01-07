import 'package:flutter/material.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({Key? key, required this.userId}) : super(key: key);
  final String userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children:  [
           Text("Followers"),
           Text("user id: $userId" ),

        ],
      )),
    );
  }
}
