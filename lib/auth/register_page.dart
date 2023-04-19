import 'package:flutter/material.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/widgets/common/default_button_widget.dart';
import 'package:social_media_app/widgets/common/text_field.dart';


class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService auth = AuthService();

  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                auth.signUp(
                    emailController.text,
                    firstNameController.text,
                    lastNameController.text,
                    usernameController.text,
                    passwordController.text,
                    confirmPasswordController.text,
                    context);
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
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
            const SizedBox(
              height: 20,
            )
          ]),
        ),
      ),
    );
  }

  SnackBar snackBarMessage(String s, Color color) {
    return SnackBar(
      duration: const Duration(milliseconds: 800),
      backgroundColor: color,
      content: Text(
        s,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
