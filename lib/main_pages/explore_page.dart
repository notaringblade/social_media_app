import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:social_media_app/services/auth_user.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin {
  List<UserModel> usersList = [];
  String currentUserId = '';
  final AuthUser _authUser = AuthUser();
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');

  Future refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    currentUserId = user!.uid;
    // _authUser.fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Explore Page ",
            style: TextStyle(color: Colors.white),
          ),
          StreamBuilder(
            stream: _authUser.fetchUsers(user!.uid),
            builder: (context, snapshot) {
              print(_authUser.usersList);
              return Expanded(
                child: LiquidPullToRefresh(
                  // animSpeedFactor: 0.5 ,
                  animSpeedFactor: 5,
                  height: 70,
                  showChildOpacityTransition: false,
                  onRefresh: refresh,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _authUser.usersList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.pushNamed('user', params: {
                                  'id': _authUser.usersList[index].uid
                                });
                              },
                              child: ListTile(
                                title:
                                    Text(_authUser.usersList[index].username),
                                subtitle: Text(
                                    "${_authUser.usersList[index].firstName} ${_authUser.usersList[index].lastName}"),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
