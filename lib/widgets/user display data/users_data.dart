import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/screens/other_user_screen.dart';
import 'package:social_media_app/widgets/common/custom_loading_widget.dart';

class UsersData extends StatelessWidget {
  final String id;

  UsersData({Key? key, required this.id}) : super(key: key);

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(id).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('username: ${data['username']}'),
                Text('name: ${data['firstName']} ${data['lastName']} ')
              ],
            ),
          );
        }
        return const CustomLoading();
      },
    );
  }
}
