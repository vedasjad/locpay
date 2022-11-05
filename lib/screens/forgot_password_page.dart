import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:locpay/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:locpay/constants.dart';
import 'package:flutter/services.dart';

class ForgotPasswordPage extends StatefulWidget {
  final Function() onClickedSignIn;
  const ForgotPasswordPage({Key? key, required this.onClickedSignIn})
      : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _userSignupFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: kContainerColour,
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.8,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/LOC-PAY.png'),
                    ),
                  ),
                ),
                Form(
                  key: _userSignupFormKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0.0, 10, 0),
                    child: Card(
                      color: kIconColour,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "Get Password Reset Mail",
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w900,
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, right: 14, left: 14, bottom: 8),
                            child: TextFormField(
                              controller: emailController,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                color: kContainerColour,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 17,
                                  color: kContainerColour,
                                ),
                                hintText: "walterwhite@gmail.com",
                                hintStyle: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 17,
                                  color: kHintColour,
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
                              ),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.emailAddress,
                              inputFormatters: [
                                FilteringTextInputFormatter.singleLineFormatter,
                              ],
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (email) {
                                email != null && !EmailValidator.validate(email)
                                    ? 'Enter a valid email'
                                    : null;
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              resetPassword;
                              widget.onClickedSignIn;
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 18,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kButtonColour,
                              ),
                              child: const Center(
                                child: Text(
                                  'Reset Password',
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: kContainerColour,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontWeight: FontWeight.w900,
                                          fontSize: 13.0,
                                          color: Colors.white,
                                        ),
                                        text: 'Remember Password? ',
                                        children: [
                                          TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = widget.onClickedSignIn,
                                            text: 'Log In',
                                            style: const TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: kContainerColour,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      Navigator.of(context).popUntil((route) => route.isFirst);
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      await Utils.showSnackBar('Password Reset Email Sent');
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());

      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
