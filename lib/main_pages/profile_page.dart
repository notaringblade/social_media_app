import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:social_media_app/config/router_constants.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/services/post_service.dart';
import 'package:social_media_app/widgets/post%20Widgets/display_posts.dart';
import 'package:social_media_app/widgets/user%20display%20data/users_data.dart';

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

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  List<PostModel> postList = [];

  Future refresh() async {
    setState(() {});
  }

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
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Profile Page",
                  style: TextStyle(color: Colors.white),
                ),
                 OutlinedButton.icon(
                      onPressed: () {
                        AuthService().logout();
                      },
                      icon: const Icon(Icons.logout_outlined),
                      label: const Text("sign out"),
                    ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            LiquidPullToRefresh(
              onRefresh: refresh,
              animSpeedFactor: 5,
              height: 70,
              // showChildOpacityTransition: false,
              child: ListView(shrinkWrap: true, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      UserDisplay(
                        users: users,
                        userId: user!.uid,
                      ),
                      TextButton(onPressed: () {
                         context.pushNamed(RouteConstants.edit,
                                params: {'id': user!.uid});
                      }, child: const Text("Edit Profile"))
                    ],
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "User Posts",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            DisplayPosts(
              userId: user!.uid,
              postService: _postService,
              user: user,
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}
