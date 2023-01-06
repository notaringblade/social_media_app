import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/services/post_service.dart';
import 'package:social_media_app/widgets/common/custom_loading_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  User? user = FirebaseAuth.instance.currentUser;
  final PostService _postService = PostService();
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');

  List<PostModel> postList = [];

  @override
  void initState() {
    // _postService.fetchPosts(postList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Profile Page",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "User Posts",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            FutureBuilder(
              future: _postService.fetchPosts(user!.uid),
              builder: (context, snapshot) {
                if (_postService.postList.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _postService.postList.length,
                      itemBuilder: (context, index) {
                        var time =
                            _postService.postList[index].created.toDate();
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: ListTile(
                                  title:
                                      Text(_postService.postList[index].post),
                                  subtitle: Text(time.toIso8601String()),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const CustomLoading();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
