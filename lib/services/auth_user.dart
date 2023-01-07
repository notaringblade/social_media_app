import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_media_app/models/user_model.dart';

class AuthUser {
  final user = FirebaseAuth.instance.currentUser;

  bool isFollowingValue = false;

  List<UserModel> usersList = [];

  List docIds = [];

  CollectionReference userFollowings =
      FirebaseFirestore.instance.collection('users');

  Stream isFollowingCheck(String uid, String otherUid) async* {
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

  Stream fetchUsers(uid) async* {
    var users = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isNotEqualTo: uid)
        .get();
    mapUsers(users);
  }

  mapUsers(QuerySnapshot<Map<String, dynamic>> users) {
    usersList= users.docs
        .map((user) => UserModel(
            firstName: user['firstName'],
            lastName: user['lastName'],
            username: user['username'],
            email: user['email'],
            uid: user['uid'],
            followers: List.from(user['followers']),
            following: List.from(user['following'])))
        .toList();

  }

  Future fetchFollowers(uid, type) async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) => value.docs.forEach((element) {
              docIds = element.data()[type];
            }));

    // for (int i = 0; i <= docIds.length; i++) {
    //   print(i);
    //   var users = await FirebaseFirestore.instance
    //       .collection('users')
    //       .where('uid', isEqualTo: docIds[i])
    //       .get();
    //   await mapUsers(users);
    // }
  }
}
