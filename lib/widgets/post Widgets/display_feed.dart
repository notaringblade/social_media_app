import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:social_media_app/config/router_constants.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:social_media_app/services/auth_user.dart';
import 'package:social_media_app/services/post_service.dart';
import 'package:social_media_app/widgets/common/custom_loading_widget.dart';

class DisplayFeed extends StatefulWidget {
  const DisplayFeed({
    Key? key,
    required this.userId,
    required PostService postService,
    required this.user,
    this.ids = const [],
  })  : _postService = postService,
        super(key: key);

  final PostService _postService;
  final User? user;
  final String userId;
  final List ids;
  @override
  State<DisplayFeed> createState() => _DisplayFeedState();
}

class _DisplayFeedState extends State<DisplayFeed> {
  final AuthUser _authUser = AuthUser();
  final PostService _postService = PostService();
  final List<Color> colors = [
    Color(0xffFD8A8A),
    Color(0xffA8D1D1),
    Color(0xffF1F7B5),
    Color(0xff9EA1D4),
  ];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _authUser.fetchFollowers(widget.user!.uid, "following"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: _postService.fetchFeed(_authUser.docIds),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (_postService.postList.isNotEmpty) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        setState(() {});
                      },
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 20,
                          );
                        },
                        shrinkWrap: true,
                        itemCount: _postService.postList.length,
                        itemBuilder: (context, index) {
                          var time =
                              _postService.postList[index].created.toDate();
                          return StreamBuilder(
                            stream: _authUser.fetchThisUser(
                                _postService.postList[index].uid),
                            builder:
                                (context, AsyncSnapshot<UserModel> snapshot) {
                              if (snapshot.hasData) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            offset: Offset(-2, -2),
                                            color: Color(0xff4E4E4E),
                                            // blurStyle: BlurStyle.normal,
                                            blurRadius: 10.0,
                                            spreadRadius: 1),
                                        BoxShadow(
                                            offset: Offset(3, 3),
                                            color: Colors.black,
                                            // blurStyle: BlurStyle.normal,
                                            blurRadius: 10.0,
                                            spreadRadius: 3),
                                      ],
                                      borderRadius: BorderRadius.circular(12),
                                      color: colors[index % colors.length],
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            context.pushNamed(
                                                RouteConstants.user,
                                                params: {
                                                  'id': snapshot.data!.uid
                                                });
                                          },
                                          child: ListTile(
                                            title: Text(
                                              snapshot.data!.username,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                            subtitle: Text(
                                              _postService.postList[index].post,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return const CustomLoading();
                              }
                            },
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView(shrinkWrap: true, children: [
                      Text("You Are Not Following Any Users That Have Posted"),
                    ]),
                  );
                }
              } else {
                return const CustomLoading();
              }
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
