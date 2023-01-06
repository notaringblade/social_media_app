// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String uid;
  final List<String> followers;
  final List<String> following;
  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.uid,
    required this.followers,
    required this.following,
  });
  
  @override
  // TODO: implement props
  List<Object> get props {
    return [
      firstName,
      lastName,
      username,
      email,
      uid,
      followers,
      following,
    ];
  }

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? uid,
    List<String>? followers,
    List<String>? following,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'uid': uid,
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      uid: map['uid'] as String,
      followers: List<String>.from((map['followers'] as List<String>)),
      following: List<String>.from((map['following'] as List<String>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
