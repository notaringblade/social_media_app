import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/services/auth_user.dart';
import 'package:social_media_app/services/fallback_services.dart';
import 'package:social_media_app/services/post_service.dart';
import 'package:social_media_app/widgets/common/text_field.dart';
import 'package:social_media_app/widgets/post%20Widgets/display_feed.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final PostService _postService = PostService();
  final AuthUser _authUser = AuthUser();
  final FallBackServices _fallback = FallBackServices();
  final user = FirebaseAuth.instance.currentUser!;
  final postController = TextEditingController();

  String currentUserId = '';

  CollectionReference userRef = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
        child: Stack(alignment: Alignment.bottomRight, children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(
          //   "Welcome ${user.email}",
          //   style: const TextStyle(color: Colors.white),
          // ),

               DisplayFeed(
                userId: user.uid,
                postService: _postService,
                user: user,
                ids: _authUser.docIds,
                
              ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            showBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                        textController: postController,
                        hintText: "write something"),
                    const SizedBox(
                      height: 50,
                    ),
                    FloatingActionButton(
                      onPressed: () async {
                        await _postService.publishPost(
                            postController.text, context);
                        postController.text = '';
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.post_add_outlined),
                    ),
                      OutlinedButton.icon(
                        onPressed: () {
                          AuthService().logout();
                        },
                        icon: const Icon(Icons.logout_outlined),
                        label: const Text("sign out"),
                      ),

                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                        Navigator.pop(context);
                            
                          });
                        },
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text(""),
                      ),
                  ],
                );
              },
            );
            // refresh();
          },
          child: const Icon(Icons.add),
        ),
      )
    ]));
  }

  SnackBar snackBarMessage(String s, Color color) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 800),
      backgroundColor: color,
      content: Text(
        s,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
