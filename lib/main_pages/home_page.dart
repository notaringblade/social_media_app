import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    void logout() async{
      await FirebaseAuth.instance.signOut();
    } 
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome ${user.email}",
            style: TextStyle(color: Colors.white),
          ),
          OutlinedButton.icon(
            onPressed: () {
              logout();
            },
            icon: Icon(Icons.logout_outlined),
            label: Text("LogOut"),
          )
        ],
      ));
  }
}
