import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:social_media_app/widgets/common/custom_loading_widget.dart';

class AuthService {
  Future<bool> usernameCheck(String username) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isEmpty;
  }

  Future signUp(
      String email,
      String firstname,
      String lastname,
      String username,
      String password,
      String confrimPassword,
      BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const CustomLoading();
        });
    try {
      if (email.isNotEmpty &&
          firstname.isNotEmpty &&
          lastname.isNotEmpty &&
          username.isNotEmpty) {
        if (checkPassword(password, confrimPassword)) {
          if (username.length > 4) {
            final message = ScaffoldMessenger.of(context);
            Future.delayed(const Duration(seconds: 2));
            final loading = Navigator.pop(context);
            final valid = await usernameCheck(username);
            if (checkEmail(email)) {
              if (valid) {
                message.showSnackBar(
                    snackBarMessage("Success!! Logging In", Colors.green));
                UserCredential user = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: email, password: password);


                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.user!.uid)
                    .set(UserModel(
                      firstName: firstname,
                      lastName: lastname,
                      username: username,
                      uid: user.user!.uid,
                      email: email,
                      followers: [],
                      following: []
                    ).toMap());

                
              } else {
                // loading;
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  snackBarMessage('username is taken', Colors.red),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                snackBarMessage(
                    'You can only login with a chowgules account', Colors.red),
              );
            }
          } else {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              snackBarMessage(
                  'Username Must Be Atleast 5 characters long', Colors.red),
            );
          }
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarMessage('Passwords Do Not Match', Colors.red),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarMessage('Provide all Data', Colors.red),
        );
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      // print(e);
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarMessage(
              'An Account is Already registered with this Email', Colors.red),
        );
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarMessage('Password Is Too Weak', Colors.red),
        );
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarMessage('Email is invalid', Colors.red),
        );
      }

      Navigator.pop(context);
    }
  }

  bool checkPassword(String password, String confrimPassword) {
    if (confrimPassword == password) {
      return true;
    } else {
      return false;
    }
  }

  bool checkEmail(String email) {
    if (email.endsWith('@chowgules.ac.in')) {
      return true;
    } else {
      return false;
    }
  }
  //Login

  Future signIn(BuildContext context, String email, String password) async {
    showDialog(
        context: context,
        builder: (context) {
          return const CustomLoading();
        });
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarMessage('Please Enter Required Information', Colors.red),
        );
      }
      Navigator.pop(context);
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarMessage('Please Check Your Email', Colors.red),
        );
      } else if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarMessage('Please Check Your Password', Colors.red),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarMessage('Please Check Your Email And Password', Colors.red),
        );
      }
      Navigator.pop(context);
    }
  }

  //logut
  Future logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  SnackBar snackBarMessage(String s, Color color) {
    return SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: color,
      content: Text(
        s,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
