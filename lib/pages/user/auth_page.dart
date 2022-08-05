import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foody/controllers/user_controller.dart';
import 'package:foody/utils/dimensions.dart';
import 'package:foody/widgets/big_text.dart';
import 'package:get/get.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  UserController userController = Get.find<UserController>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isSignUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 0.0,
          title: isSignUp
              ? const BigText(text: "Sign Up to Foody")
              : const BigText(text: "Sign In to Foody"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: 2 * Dimensions.height10,
              horizontal: 5 * Dimensions.width10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: "Password"),
            ),
            isSignUp
                ? ElevatedButton(
                    onPressed: () async => await userController.signUp(
                        emailController.text, passwordController.text),
                    child: const Text("Sign Up"))
                : ElevatedButton(
                    onPressed: () async => await userController.signIn(
                        emailController.text, passwordController.text),
                    child: const Text("Sign In")),
            isSignUp
                ? InkWell(
                    onTap: () => setState(() => isSignUp = false),
                    child: const Text("Sign in Instead?",
                        style: TextStyle(
                            color: Colors.teal,
                            decoration: TextDecoration.underline)),
                  )
                : InkWell(
                    onTap: () => setState(() => isSignUp = true),
                    child: const Text("Sign up Instead?",
                        style: TextStyle(
                            color: Colors.teal,
                            decoration: TextDecoration.underline)))
          ]),
        ));
  }
}
