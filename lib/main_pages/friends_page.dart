import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/user%20display%20data/users_data.dart';

class FriendsPage extends StatefulWidget {
  FriendsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  User? user = FirebaseAuth.instance.currentUser;

  List<dynamic> docIds = [];

  Future getDocIds() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user!.email)
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              // docIds.add(element.data()['friends'].toString());
              docIds = element.data()['friends'];
            }));
  }

  late final Future future;
  @override
  void initState() {
    super.initState();
    future = getDocIds();
  }

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "FriendsPage",
            style: TextStyle(color: Colors.white),
          ),
          FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              return Expanded(
                child: ListView.builder(
                  itemCount: docIds.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: ListTile(
                          title: UsersData(id: docIds[index],)
                      )
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
