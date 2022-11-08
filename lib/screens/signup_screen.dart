import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:locpay/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:locpay/main.dart';
import 'package:locpay/widgets/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locpay/services/firebase_database.dart';
import 'package:locpay/services/user_information.dart';
import 'auth_screen.dart';
import 'package:locpay/services/globals.dart' as globals;

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUpWidget({Key? key, required this.onClickedSignIn})
      : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final _userSignupFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  Widget buildPayer(Payer payer) => ListTile(
        leading: CircleAvatar(
          child: Text(payer.name),
        ),
        title: Text(payer.name),
        subtitle: Text(payer.email),
      );

  Future createPayer(Payer user) async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(emailController.text);

    final json = user.toJson();

    await docUser.set(json);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
                              "Welcome",
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w900,
                                fontSize: 32.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, right: 14, left: 14, bottom: 8),
                            child: TextFormField(
                              controller: nameController,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
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
                                labelText: 'Name',
                                labelStyle: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 17,
                                  color: kContainerColour,
                                ),
                                hintText: "Walter White",
                                hintStyle: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 17,
                                  color: kHintColour,
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
                              ),
                              cursorColor: Colors.black,
                              inputFormatters: [
                                FilteringTextInputFormatter.singleLineFormatter,
                              ],
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
                                labelText: 'New Email',
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
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, right: 14, left: 14, bottom: 8),
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              controller: passwordController,
                              obscureText: _obscureText,
                              style: const TextStyle(
                                color: kContainerColour,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                                fontSize: 17,
                              ),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                labelText: 'Password',
                                labelStyle: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 17,
                                  color: kContainerColour,
                                ),
                                hintText: "x37ru82#",
                                hintStyle: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 17,
                                  color: kHintColour,
                                ),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 15.0, 20.0, 5.0),
                                suffixIcon: IconButton(
                                  color: kContainerColour,
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: _toggle,
                                ),
                              ),
                              cursorColor: Colors.black,
                              inputFormatters: [
                                FilteringTextInputFormatter.singleLineFormatter,
                              ],
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                value != null && value.length < 6
                                    ? 'Enter minimum 6 characters'
                                    : null;
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () async {
                              signUp();
                              // globals.name = nameController.text;
                              // globals.email = emailController.text;
                              // UserInformation().email = emailController.text;
                              // UserInformation().name = nameController.text;
                              final user = Payer(
                                name: nameController.text,
                                email: emailController.text,
                              );
                              createPayer(user);
                              readPayer();
                              debugPrint('${globals.name}k');
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
                                  'Sign Up',
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
                                        text: 'Already have an account? ',
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

  Future signUp() async {
    final isValid = _userSignupFormKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      // readPayer();
      // debugPrint('${name}k');
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      readPayer();
      debugPrint('${name}k');
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());

      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
