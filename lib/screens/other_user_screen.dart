import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/common/custom_loading_widget.dart';

class OtherUserScreen extends StatefulWidget {
  final String userId;
  final String currentUserId;

  const OtherUserScreen({Key? key, required this.userId, required this.currentUserId}) : super(key: key);

  @override
  State<OtherUserScreen> createState() => _OtherUserScreenState();
}

class _OtherUserScreenState extends State<OtherUserScreen> {

   User? user = FirebaseAuth.instance.currentUser;

  late final Future<DocumentSnapshot> future;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void addFirend(){
    users.doc(widget.currentUserId).update(
      {
        'friends': FieldValue.arrayUnion([widget.userId])
      }
    );
    SetOptions(merge: true);
    print(widget.currentUserId);
    print(widget.userId);
  }

  @override
  void initState() {
    // TODO: implement initState
    future = users.doc(widget.userId).get();
    print("hello");
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          FloatingActionButton(onPressed: () {
            addFirend();
          }),
          FutureBuilder<DocumentSnapshot>(
      future: future,
      builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return GestureDetector(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('username: ${data['username']}'),
                    Text('name: ${data['firstName']} ${data['lastName']} ')
                  ],
                ),
              ),
            );
          }
          return const CustomLoading();
      },
    )
      ],
    ),
        ));
  }
}
