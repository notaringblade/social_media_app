import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:social_media_app/screens/other_user_screen.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<UserModel> usersList = [];
  String currentUserId = '';
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    currentUserId = user!.uid;
    fetchUsers();
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((event) {});
    super.initState();
  }

  fetchUsers() async {
    var users = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isNotEqualTo: user!.uid)
        .get();
    mapUsers(users);
  }

  mapUsers(QuerySnapshot<Map<String, dynamic>> users) {
    var list = users.docs
        .map((user) => UserModel(
            firstName: user['firstName'],
            lastName: user['lastName'],
            username: user['username'],
            email: user['email'],
            uid: user['uid'],
            followers: List.from(user['followers']),
            following: List.from(user['following'])))
        .toList();
    if (mounted) {
      setState(() {
        usersList = list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Explore Page ",
            style: TextStyle(color: Colors.white),
          ),
          
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: usersList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pushNamed('user', params: {'id': usersList[index].uid});
                        },
                        child: ListTile(
                          title: Text(usersList[index].username),
                          subtitle: Text(
                              "${usersList[index].firstName} ${usersList[index].lastName}"),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
