import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/bloc/bloc/user_data_bloc.dart';
import 'package:social_media_app/services/auth_user.dart';
import 'package:social_media_app/widgets/common/custom_loading_widget.dart';

class FollowersScreen extends StatefulWidget {
  FollowersScreen({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  final AuthUser _authUser = AuthUser();
  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment:  MainAxisAlignment.start,
        children: [
            SizedBox(height: 40,),
            Text("Followers"),
            SizedBox(height: 40,),
            // Text("user id: ${widget.userId}"),
            // SizedBox(height: 40,),
            FutureBuilder(
              future: _authUser.fetchFollowers(widget.userId),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done){

                print(_authUser.usersList);
                if(_authUser.usersList.isNotEmpty){

                return Expanded(
                  child: ListView.builder(
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
                                title: Text(_authUser.usersList[index].username),
                                subtitle: Text(
                                    "${_authUser.usersList[index].firstName} ${_authUser.usersList[index].lastName}"),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
                }else{
                  return Text("This user Has no followers");
                }
                }else{
                  return CustomLoading();
                }
              },
            )
        ],
      ),
          )),
    );
  }
}
