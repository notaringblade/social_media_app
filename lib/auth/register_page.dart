import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:social_media_app/widgets/common/default_button_widget.dart';
import 'package:social_media_app/widgets/common/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  


  Future addUserData() async {

    UserModel user = UserModel(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      username: usernameController.text,
      email: emailController.text,
      friends: [],
    );

    await FirebaseFirestore.instance
              .collection('users')
              .add(user.toMap());
  }

  Future signUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        });

    

    try {
      if (emailController.text.isNotEmpty &&
          usernameController.text.isNotEmpty &&
          firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty) {
        if (checkPassword()) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
          addUserData();
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarMessage('Passwords Do Not Match', Colors.red),
          );
        } 
      }else {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarMessage('Please Provide Required Data', Colors.red),
          );
        }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarMessage('This Email Is Taken', Colors.red),
        );
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarMessage('Password Is Too Weak', Colors.red),
        );
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarMessage('Email is Invalid', Colors.red),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarMessage('Please Check Your Email And Password', Colors.red),
        );
      }
      Navigator.pop(context);
    }
  }

  bool checkPassword() {
    if (confirmPasswordController.text.trim() ==
        passwordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            const Icon(
              Icons.lock_outline,
              size: 100,
              color: Colors.white,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Become A Member Today!!",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
                textController: usernameController, hintText: "username"),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
                textController: firstNameController, hintText: "first name"),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
                textController: lastNameController, hintText: "last name"),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(textController: emailController, hintText: "email"),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              textController: passwordController,
              hintText: "password",
              obscure: true,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              textController: confirmPasswordController,
              hintText: "confirm password",
              obscure: true,
            ),
            const SizedBox(
              height: 40,
            ),
            DefaultButtonWidget(
              onTap: () {
                signUp();
              },
              buttonName: 'Sign Up',
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already a Member?",
                  style: TextStyle(color: Colors.white),
                ),
                InkWell(
                    onTap: widget.onTap!,
                    child: const Text(
                      "   Sign In",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            )
          ]),
        ),
      ),
    );
  }

  SnackBar snackBarMessage(String s, Color color) {
    return SnackBar(
      duration: Duration(milliseconds: 800),
      backgroundColor: color,
      content: Text(
        s,
        textAlign: TextAlign.center,
      ),
    );
  }
}
