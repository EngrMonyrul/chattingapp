import 'package:chattingapp/pages/loginpage_view.dart';
import 'package:chattingapp/pages/registerpage_view.dart';
import 'package:flutter/material.dart';

class LoginOrRegisterView extends StatefulWidget {
  const LoginOrRegisterView({super.key});

  @override
  State<LoginOrRegisterView> createState() => _LoginOrRegisterViewState();
}

class _LoginOrRegisterViewState extends State<LoginOrRegisterView> {
  bool _showLogin = true;

  void toggleLoginPage() {
    setState(() {
      _showLogin = !_showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showLogin) {
      return LoginPageView(loginTap: toggleLoginPage);
    } else {
      return RegisterPageView(registerTap: toggleLoginPage);
    }
  }
}
