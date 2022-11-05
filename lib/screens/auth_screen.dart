import 'package:flutter/material.dart';
import 'package:locpay/screens/signin_screen.dart';
import 'forgot_password_page.dart';
import 'signup_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool hasPassword = true;
  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      if (hasPassword) {
        return SignInWidget(
            onClickedSignUp: toggle, onClickedPassword: toggle1);
      } else {
        return ForgotPasswordPage(onClickedSignIn: toggle1);
      }
    } else {
      if (hasPassword) {
        return SignUpWidget(onClickedSignIn: toggle);
      } else {
        return ForgotPasswordPage(onClickedSignIn: toggle1);
      }
    }
  }

  void toggle() => setState(() {
        isLogin = !isLogin;
      });

  void toggle1() => setState(() {
        hasPassword = !hasPassword;
      });
}
