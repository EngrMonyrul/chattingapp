// ignore_for_file: use_build_context_synchronously

import 'package:chattingapp/components/mybutton_widget.dart';
import 'package:chattingapp/components/textfield_view.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_services.dart';

class LoginPageView extends StatefulWidget {
  final Function() loginTap;

  const LoginPageView({super.key, required this.loginTap});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthServices authServices = AuthServices();

  onTapFun() async {
    try {
      await authServices.signInWithEmailAndPass(
          email: _emailController.text, password: _passwordController.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(e.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              "Welcome back, you've been missed!",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 30),
            TextFieldView(
              hintText: 'Email',
              textEditingController: _emailController,
              obsecureText: false,
            ),
            const SizedBox(height: 10),
            TextFieldView(
              hintText: 'Password',
              textEditingController: _passwordController,
              obsecureText: true,
            ),
            const SizedBox(height: 20),
            MyButton(
              buttonText: 'Login',
              onTap: onTapFun,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: widget.loginTap,
                  child: Text(
                    'Register Now!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
