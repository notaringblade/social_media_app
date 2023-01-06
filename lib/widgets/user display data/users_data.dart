import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/screens/other_user_screen.dart';
import 'package:social_media_app/widgets/common/custom_loading_widget.dart';

class UsersData extends StatefulWidget {
  final String id;

  const UsersData({Key? key, required this.id}) : super(key: key);

  @override
  State<UsersData> createState() => _UsersDataState();
}

class _UsersDataState extends State<UsersData> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  User? user = FirebaseAuth.instance.currentUser!;

  String currentUserId = '';

  Future getDocIds() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user?.email)
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              print(element.reference);
              currentUserId = element.reference.id;
            }));
  }

  @override
  void initState() {
    getDocIds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.id).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Container(
            // color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('username: ${data['username']}'),
                Text('name: ${data['firstName']} ${data['lastName']} '),
                Text('email: ${data['email']} '),
              ],
            ),
          );
        }
        return const CustomLoading();
      },
    );
  }
}
