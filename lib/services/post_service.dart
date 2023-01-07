import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/models/post_model.dart';

class PostService {
  String currentUser = FirebaseAuth.instance.currentUser!.uid;
  List<PostModel> postList = [];
  Future publishPost(String text, BuildContext context) async {
    if (text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBarMessage("Cant Be Empty", Colors.red));
    } else {
      await FirebaseFirestore.instance.collection('posts').add(PostModel(
              post: text, uid: currentUser, likes: [], created: Timestamp.now())
          .toMap());
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBarMessage("Post Added", Colors.green));
    }
  }

  SnackBar snackBarMessage(String s, Color color) {
    return SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: color,
      content: Text(
        s,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Future fetchPosts(String id) async {
    var posts = await FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: id)
        .orderBy('post', descending: true)
        .get();
    mapPosts(posts);
  }

  Future mapPosts(QuerySnapshot<Map<String, dynamic>> posts) async {
    var list = posts.docs
        .map((post) => PostModel(
            post: post['post'],
            likes: List.from(post['likes']),
            uid: post['uid'],
            created: post['created']))
        .toList();
    postList = list;
    print(postList.length);
  }
}
