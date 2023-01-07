import 'package:cloud_firestore/cloud_firestore.dart';

class FallBackServices{
  void addSubCollections(){
     FirebaseFirestore.instance.collection('users').get().then((value) => value.docs.forEach((element) {
      FirebaseFirestore.instance.doc(element.reference.path).update({
        'following': [],
        'followers': []
      });
      // FirebaseFirestore.instance.doc(element.reference.path).collection('following').doc().set({});
    }));
  }
}