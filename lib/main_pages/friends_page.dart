import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/bloc/bloc/user_data_bloc.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:social_media_app/screens/other_user_screen.dart';
import 'package:social_media_app/widgets/common/custom_loading_widget.dart';
import 'package:social_media_app/widgets/user%20display%20data/users_data.dart';

class FriendsPage extends StatefulWidget {
  FriendsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage>
    with AutomaticKeepAliveClientMixin {
  List<dynamic> followingIds = [];
  String currentUserId = '';

  User? currentUser = FirebaseAuth.instance.currentUser!;
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    userRef
        .where('uid', isEqualTo: currentUser?.uid)
        .get()
        .then((value) => value.docs.forEach((element) {
              currentUserId = element.reference.id;
            }));
    super.initState();
  }

  Stream fetchUsers() async* {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: currentUser?.email)
        .get()
        .then((value) => value.docs.forEach((element) {
              followingIds = element.data()['following'];
            }));
    userRef.snapshots();
  }

  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Following",
            style: TextStyle(color: Colors.white),
          ),
          FloatingActionButton(onPressed: () {
            setState(() {});
          }),
          StreamBuilder(
            stream: fetchUsers(),
            builder: (context, snapshot) {
              if (followingIds.isEmpty) {
                return const Center(
                  child: Text("Not Following Anyone"),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: followingIds.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OtherUserScreen(
                                        userId: followingIds[index],
                                        ),
                                  )).then((_) {setState(() {
                                    
                                  });});
                            },
                            child: Container(
                              width: 300,
                              child: ListTile(
                                title: UsersData(
                                  id: followingIds[index],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}