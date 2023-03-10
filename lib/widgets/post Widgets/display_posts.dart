import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/services/post_service.dart';
import 'package:social_media_app/widgets/common/custom_loading_widget.dart';

class DisplayPosts extends StatefulWidget {
  const DisplayPosts({
    Key? key,
    required this.userId,
    required PostService postService,
    required this.user,
  }) : _postService = postService, super(key: key);

  final PostService _postService;
  final User? user;
  final String userId;
  

  @override
  State<DisplayPosts> createState() => _DisplayPostsState();
}

class _DisplayPostsState extends State<DisplayPosts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return FutureBuilder(
              future: widget._postService.fetchPosts(widget.userId),
              builder: (context, snapshot) {
    if(snapshot.connectionState == ConnectionState.done){

    if (widget._postService.postList.isNotEmpty) {
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget._postService.postList.length,
          itemBuilder: (context, index) {
            var time =
                widget._postService.postList[index].created.toDate();
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: ListTile(
                      title:
                          Text(widget._postService.postList[index].post),
                      subtitle: Text(time.toIso8601String()),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      return const Center(child: Text("No Posts from this User"),);
    }
    }else{
      return const CustomLoading();
    }
              },
            );
  }
}