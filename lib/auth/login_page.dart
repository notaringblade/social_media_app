import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
        backgroundColor: const Color(0xff222222),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              child: textField(emailController),
            ),
            SizedBox(height: 20,),
            SizedBox(
              child: textField(passwordController),
            ),
          ],
        ));
  }

  TextFormField textField(TextEditingController textController) {
    return TextFormField(
              controller: textController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
              ),
            );
  }
}