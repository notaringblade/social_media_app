import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/widgets/common/custom_loading_widget.dart';
import 'package:social_media_app/widgets/common/default_button_widget.dart';
import 'package:social_media_app/widgets/common/text_field.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            const SizedBox(
              height: 140,
            ),
            const Icon(
              Icons.lock_outline,
              size: 100,
              color: Colors.white,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Sign In To Continue",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              textController: emailController,
              hintText: "email",
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              textController: passwordController,
              hintText: "password",
              obscure: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.white70),
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            DefaultButtonWidget(
              onTap: (){
                auth.signIn(context, emailController.text, passwordController.text);
              },
              buttonName: 'Sign In',
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Not A Member Yet?",
                  style: TextStyle(color: Colors.white),
                ),
                InkWell(
                    onTap: widget.onTap!,
                    child: const Text(
                      "   Sign Up",
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

  SnackBar snackBarMessage(String s) {
    return SnackBar(
      duration: Duration(milliseconds: 800),
      backgroundColor: Colors.red,
      content: Text(
        s,
        textAlign: TextAlign.center,
      ),
    );
  }
}
