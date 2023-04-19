import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/common/default_button_widget.dart';
import 'package:social_media_app/widgets/common/text_field.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

TextEditingController usernameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.userId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data!
              .data() as Map<String, dynamic>;
              return SingleChildScrollView(
                // physics: NeverScrollableScrollPhysics(),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  const SizedBox(
                    height: 160,
                  ),
                  const Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    textController: usernameController,
                    hintText: data['username'],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    textController: emailController,
                    hintText: data['email'],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    textController: firstNameController,
                    hintText: data['firstName'],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    textController: lastNameController,
                    hintText: data['lastName'],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  DefaultButtonWidget(onTap: () {}, buttonName: "update"),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
              );
            } else {
              return Scaffold();
            }
          }),
    );
  }
}
