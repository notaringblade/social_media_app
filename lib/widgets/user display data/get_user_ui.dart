import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/common/custom_loading_widget.dart';

class GetUserUi extends StatefulWidget {
  const GetUserUi({Key? key, required this.docId}) : super(key: key);

  final String docId;

  @override
  State<GetUserUi> createState() => _GetUserUiState();
}

final CollectionReference users =
    FirebaseFirestore.instance.collection('users');

class _GetUserUiState extends State<GetUserUi> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.docId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Text("username: ${data['username']}");
        } else {
          return CustomLoading();
        }
      },
    );
  }
}
