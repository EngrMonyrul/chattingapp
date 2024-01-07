// ignore_for_file: use_build_context_synchronously

import 'package:chattingapp/components/mybutton_widget.dart';
import 'package:chattingapp/components/textfield_view.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_services.dart';

class RegisterPageView extends StatefulWidget {
  final Function() registerTap;

  const RegisterPageView({super.key, required this.registerTap});

  @override
  State<RegisterPageView> createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<RegisterPageView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthServices _authServices = AuthServices();

  onTapFun() async {
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        await _authServices.signUpWithEmailAndPass(
            email: _emailController.text, pass: _passwordController.text);
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
              "Let's create an account for you",
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
            TextFieldView(
              hintText: 'Confirm Password',
              textEditingController: _confirmPasswordController,
              obsecureText: true,
            ),
            const SizedBox(height: 20),
            MyButton(
              buttonText: 'Register',
              onTap: onTapFun,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: widget.registerTap,
                  child: Text(
                    'Login Now!',
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
