import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/config/router_constants.dart';
import 'package:social_media_app/widgets/common/custom_loading_widget.dart';

class UserDisplay extends StatefulWidget {
  const UserDisplay({
    Key? key,
    required this.users,
    required this.userId,
  }) : super(key: key);

  final CollectionReference<Object?> users;
  final String userId;
  @override
  State<UserDisplay> createState() => _UserDisplayState();
}


class _UserDisplayState extends State<UserDisplay> {
  @override
  void initState() {
    // TODO: implement initState
    // widget.refresh;
    // setState(() {
    // });
    
    super.initState();
  }
  Widget build(BuildContext context) {
    setState(() {
      
    });
    return FutureBuilder<DocumentSnapshot>(
      future:  widget.users.doc(widget.userId).get(),
      builder: (context, snapshot) {

        if (snapshot.connectionState ==
            ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!
              .data() as Map<String, dynamic>;
            var followers = data['followers'].length;
          return SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment:
                      MainAxisAlignment.start,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text('username: ${data['username']}'),
                    Text(
                        'name: ${data['firstName']} ${data['lastName']}'),
                    // Text('email: ${widget.currentUserId} '),
                    // Text( "followers: ${arrayLength.toString()}"),
                  ],
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        
                        context.pushNamed(RouteConstants.followers,
                                params: {'id': widget.userId, 'type': 'followers'});
                      },
                      child: Column(
                        children: [
                          Text('followers'),
                          Text( followers.toString()),
                        ],
                      ),
                    ),
                    SizedBox(width: 30,),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(RouteConstants.followers,
                                params: {'id': widget.userId, 'type': 'following'});
                      },
                      child: Column(
                        children: [
                          Text('following'),
                          Text('${data['following'].length}'),
                        ],
                      ),
                    )

                  ],
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}