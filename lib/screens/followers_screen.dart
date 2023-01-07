import 'package:flutter/material.dart';
import 'package:social_media_app/services/auth_user.dart';
import 'package:social_media_app/widgets/user%20display%20data/follow_list.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({Key? key, required this.userId, required this.type}) : super(key: key);
  final String userId;
  final String type;

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
            const SizedBox(height: 40,),
             Text(widget.type),
            const SizedBox(height: 40,),
            FloatingActionButton(onPressed: () {
              setState(() {
                
              });
            },),
            FollowDisplay(authUser: _authUser, id: widget.userId, type: widget.type,)
        ],
      ),
          )),
    );
  }
}


