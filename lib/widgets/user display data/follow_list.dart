import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/config/router_constants.dart';
import 'package:social_media_app/screens/followers_screen.dart';
import 'package:social_media_app/services/auth_user.dart';
import 'package:social_media_app/widgets/common/custom_loading_widget.dart';
import 'package:social_media_app/widgets/user%20display%20data/get_user_ui.dart';

class FollowDisplay extends StatelessWidget {
  const FollowDisplay({
    Key? key,
    required AuthUser authUser,
    required this.id,
    required this.type,
  })  : _authUser = authUser,
        super(key: key);

  final AuthUser _authUser;
  final String id;
  final String type;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authUser.fetchFollowers(id, type),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // print(_authUser.usersList);
          if(_authUser.docIds.isNotEmpty){

          return Expanded(
            child: ListView.builder(
              itemCount: _authUser.docIds.length,
              itemBuilder: (context, index) {
                // print(_authUser.usersList.length);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          context.pushNamed(RouteConstants.user,
                              params: {'id': _authUser.docIds[index]});
                        },
                        child: Container(
                          color: Colors.black,
                          child: ListTile(
                            title: GetUserUi(docId: _authUser.docIds[index]),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
          }else{
            return Text('no $type to spy on');
          }
        } else {
          return CustomLoading();
        }
      },
    );
  }
}
