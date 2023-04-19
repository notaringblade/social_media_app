// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostModel extends Equatable {

  final String post;
  final String uid;
  final Timestamp created;
  final List<String> likes;
  const PostModel({
    required this.post,
    required this.uid,
    required this.created,
    required this.likes,
  });
  

  @override
  List<Object> get props => [post, uid, created, likes];


  PostModel copyWith({
    String? post,
    String? uid,
    Timestamp? created,
    List<String>? likes,
  }) {
    return PostModel(
      post: post ?? this.post,
      uid: uid ?? this.uid,
      created: created ?? this.created,
      likes: likes ?? this.likes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'post': post,
      'uid': uid,
      'created': created,
      'likes': likes,
    };
  }


  @override
  bool get stringify => true;

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      post: map['post'] as String,
      uid: map['uid'] as String,
      created: map['created'] as Timestamp,
      likes: List<String>.from((map['likes'] as List<String>),
    ));
  }

  
}
