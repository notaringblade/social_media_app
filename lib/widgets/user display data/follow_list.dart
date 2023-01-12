import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/config/router_constants.dart';
import 'package:social_media_app/screens/followers_screen.dart';
import 'package:social_media_app/services/auth_user.dart';
import 'package:social_media_app/widgets/common/custom_loading_widget.dart';
import 'package:social_media_app/widgets/user%20display%20data/get_user_ui.dart';

class FollowDisplay extends StatelessWidget {
  FollowDisplay({
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
  final List<Color> colors = [
    Color(0xffFD8A8A),
    Color(0xffA8D1D1),
    Color(0xffF1F7B5),
    Color(0xff9EA1D4),
  ];
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authUser.fetchFollowers(id, type),
      builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // print(_authUser.usersList);
            if (_authUser.docIds.isNotEmpty) {
              print(_authUser.docIds);
              return Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 20,
                    );
                  },
                  itemCount: _authUser.docIds.length,
                  itemBuilder: (context, index) {
                    // print(_authUser.usersList.length);
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(RouteConstants.user,
                            params: {'id': _authUser.docIds[index]});
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
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
                                border: Border.all(
                                    color: colors[index % colors.length],
                                    width: 3),
                                color: Color(0xff222222),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      // color: Colors.black,
                                      child: ListTile(
                                    title: GetUserUi(
                                        docId: _authUser.docIds[index]),
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Text('no $type to spy on');
            }
          } else {
            return CustomLoading();
          }
       
      },
    );
  }
}
