import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/services/auth_user.dart';
import 'package:social_media_app/services/post_service.dart';
import 'package:social_media_app/widgets/common/custom_loading_widget.dart';
import 'package:social_media_app/widgets/post%20Widgets/display_posts.dart';
import 'package:social_media_app/widgets/user%20display%20data/users_data.dart';

class OtherUserScreen extends StatefulWidget {
  final String userId;

  const OtherUserScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<OtherUserScreen> createState() => _OtherUserScreenState();
}

class _OtherUserScreenState extends State<OtherUserScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  List<PostModel> postList = [];

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final PostService _postService = PostService();
  final AuthUser _authUser = AuthUser();
  late final Future future;
  @override
  void initState() {
    _postService.fetchPosts(widget.userId);
    super.initState();
  }

  bool isFollowing = false;
  List followingList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            // shrinkWrap: true,
            children: [
              const SizedBox(
                height: 40,
              ),
              LiquidPullToRefresh(
                animSpeedFactor: 5,
                height: 50,
                showChildOpacityTransition: false,
                onRefresh: () async {},
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      UserDisplay(users: users, userId: widget.userId),
                      StreamBuilder(
                        stream:
                            _authUser.isFollowingCheck(user!.uid, widget.userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return Column(
                              children: [
                                widget.userId == user!.uid
                                    ? Container()
                                    : _authUser.isFollowingValue
                                        ? TextButton(
                                            onPressed: () async {
                                              await _authUser
                                                  .unfolloUser(widget.userId);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBarMessage(
                                                      'Unfollowed User',
                                                      Colors.white));
                                              setState(() {});
                                            },
                                            child: const Text("unfollow"))
                                        : TextButton(
                                            onPressed: () async {
                                              await _authUser
                                                  .followUser(widget.userId);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBarMessage(
                                                      'Followed user',
                                                      Colors.white));
                                              setState(() {});
                                            },
                                            child: const Text("follow")),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  'User Posts',
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [

              //   ],
              // ),
              DisplayPosts(
                  postService: _postService, user: user, userId: widget.userId)

              // : Text("No Posts")
            ],
          ));
        }),
      ),
    );
  }

  SnackBar snackBarMessage(String s, Color color) {
    return SnackBar(
      duration: Duration(milliseconds: 800),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      content: Text(
        s,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
