// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final List<UserModel> friends;
  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.friends,
  });
  
  @override
  // TODO: implement props
  List<Object> get props {
    return [
      firstName,
      lastName,
      username,
      email,
      friends,
    ];
  }

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    List<UserModel>? friends,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      friends: friends ?? this.friends,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'friends': friends.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      friends: List<UserModel>.from((map['friends'] as List<int>).map<UserModel>((x) => UserModel.fromMap(x as Map<String,dynamic>),),),
    );
  }



  @override
  bool get stringify => true;
}
