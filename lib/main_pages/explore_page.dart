import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/screens/other_user_screen.dart';
import 'package:social_media_app/widgets/common/custom_loading_widget.dart';
import 'package:social_media_app/widgets/user%20display%20data/users_data.dart';

class ExplorePage extends StatefulWidget {
  ExplorePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  User? user = FirebaseAuth.instance.currentUser;

  List<String> docIds = [];
  String currentUserId = '';

  Future getDocIds() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isNotEqualTo: user?.email)
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              print(element.reference);
              docIds.add(element.reference.id);
            }));

    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user?.email)
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              print(element.reference);
              currentUserId = element.reference.id;
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
          Text(
            "ExplorePage",
            style: TextStyle(color: Colors.white),
          ),
          FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              // if (docIds.isNotEmpty) {
              //   return Expanded(
              //     child: ListView.builder(
              //       itemCount: docIds.length,
              //       itemBuilder: (context, index) {
              //         return GestureDetector(
              //           onTap: () {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) =>
              //                       OtherUserScreen(userId: docIds[index]),
              //                 ));
              //           },
              //           child: ListTile(
              //               title: UsersData(
              //             id: docIds[index],
              //           )),
              //         );
              //       },
              //     ),
              //   );
              // } else if (snapshot.hasError) {
              //   return Center(
              //     child: Text("", style: TextStyle(color: Colors.white)),
              //   );
              // } else {
              //   return const CustomLoading();
              // }
              return Expanded(
                child: ListView.builder(
                  itemCount: docIds.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OtherUserScreen(userId: docIds[index], currentUserId: currentUserId),
                            ));
                      },
                      child: ListTile(
                          title: UsersData(
                        id: docIds[index],
                      )),
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
