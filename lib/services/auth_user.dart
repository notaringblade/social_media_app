import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_media_app/models/user_model.dart';

class AuthUser {
  final user = FirebaseAuth.instance.currentUser;

  bool isFollowingValue = false;

  List<UserModel> usersList = [];

  CollectionReference userFollowings =
      FirebaseFirestore.instance.collection('users');

  Future isFollowingCheck(String uid, String otherUid) async {
    DocumentSnapshot snap = await userFollowings.doc(uid).get();

    List following = (snap.data()! as dynamic)['following'];

    if (following.contains(otherUid)) {
      isFollowingValue = true;
    } else {
      isFollowingValue = false;
    }
  }

  Future followUser(String otherUid) async {
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'following': FieldValue.arrayUnion([otherUid])
    });

    await FirebaseFirestore.instance.collection('users').doc(otherUid).update({
      'followers': FieldValue.arrayUnion([user!.uid])
    });
  }

  Future unfolloUser(String otherUid) async {
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'following': FieldValue.arrayRemove([otherUid])
    });

    await FirebaseFirestore.instance.collection('users').doc(otherUid).update({
      'followers': FieldValue.arrayRemove([user!.uid])
    });
  }


  Future fetchUsers() async {
    var users = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isNotEqualTo: user!.uid)
        .get();
    mapUsers(users);
  }

   mapUsers(QuerySnapshot<Map<String, dynamic>> users) {
    var list = users.docs
        .map((user) => UserModel(
            firstName: user['firstName'],
            lastName: user['lastName'],
            username: user['username'],
            email: user['email'],
            uid: user['uid'],
            followers: List.from(user['followers']),
            following: List.from(user['following'])
            ))
        .toList();

      usersList = list;
  }

}
