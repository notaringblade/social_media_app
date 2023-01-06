import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/widgets/common/custom_loading_widget.dart';

class OtherUserScreen extends StatefulWidget {
  final String userId;

  const OtherUserScreen(
      {Key? key, required this.userId})
      : super(key: key);

  @override
  State<OtherUserScreen> createState() => _OtherUserScreenState();
}

class _OtherUserScreenState extends State<OtherUserScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  late final Future<DocumentSnapshot> future;

  List<PostModel> postList = [];

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    fetchPosts();
    super.initState();
  }

  

  fetchPosts() async {
    var posts = await FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: widget.userId)
        .get();
    mapPosts(posts);
  }

  mapPosts(QuerySnapshot<Map<String, dynamic>> posts) {
    var list = posts.docs
        .map((post) => PostModel(
            post: post['post'],
            likes: List.from(post['likes']),
            uid: post['uid'],
            created: post['created']
            ))
        .toList();
    setState(() {
      postList = list;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FloatingActionButton(
              heroTag: 'tag',
              onPressed: () {
              
              print("object");
              
            }),
            FutureBuilder<DocumentSnapshot>(
              future: users.doc(widget.userId).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var check = snapshot.data!;
                  int arrayLength=check['followers'].length;
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('username: ${data['username']}'),
                        Text('name: ${data['firstName']} ${data['lastName']} '),
                        // Text('email: ${widget.currentUserId} '),
                        Text( "followers: ${arrayLength.toString()}"),
                      ],
                    ),
                  );
                }
                return const CustomLoading();
              },
            ),
            postList.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(postList[index].post),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Text("No Posts")
          ],
              ),
            ),
        ));
  }
}
