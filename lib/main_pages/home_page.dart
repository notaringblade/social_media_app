import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/services/fallback_services.dart';
import 'package:social_media_app/services/post_service.dart';
import 'package:social_media_app/widgets/common/text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostService _postService =  PostService();
  final FallBackServices _fallback = FallBackServices();
  final user = FirebaseAuth.instance.currentUser!;
  final postController = TextEditingController();

  String currentUserId = '';

  

  CollectionReference userRef = FirebaseFirestore.instance.collection('users');
  @override
  void initState() {
    userRef
        .where('uid', isEqualTo: user.uid)
        .get()
        .then((value) => value.docs.forEach((element) {
              currentUserId = element.reference.id;
            }));
    
    super.initState();
  }

  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Welcome ${user.email}",
          style: TextStyle(color: Colors.white),
        ),
        // FloatingActionButton(onPressed: () {

        //   _fallback.addSubCollections();
        // },
        // child: Text("Fallback"),
        // ),
        OutlinedButton.icon(
          onPressed: () {
            AuthService().logout();
          },
          icon: Icon(Icons.logout_outlined),
          label: Text("LogOut"),
        ),
        CustomTextField(textController: postController, hintText: 'title'),
        SizedBox(
          height: 30,
        ),
        FloatingActionButton(onPressed: () {
          _postService.publishPost(postController.text, context);
          postController.text = "";
        })
      ],
    ));
  }

  SnackBar snackBarMessage(String s, Color color) {
    return SnackBar(
      duration: Duration(milliseconds: 800),
      backgroundColor: color,
      content: Text(
        s,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
