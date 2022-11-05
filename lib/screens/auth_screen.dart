import 'package:flutter/material.dart';
import 'package:locpay/screens/signin_screen.dart';
import 'signup_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? SignInWidget(onClickedSignUp: toggle)
      : SignUpScreen(onClickedSignIn: toggle);

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
