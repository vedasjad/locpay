import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:locpay/constants.dart';
import 'package:locpay/screens/home_screen.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:locpay/services/firebase_services.dart';
import 'package:locpay/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:locpay/services/google_signin.dart';
import 'package:provider/provider.dart';
import 'package:locpay/widgets/utils.dart';
import 'package:locpay/services/user_information.dart';
import 'package:locpay/services/globals.dart' as globals;
import 'package:locpay/widgets/textformfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  final VoidCallback onClickedPassword;
  const SignInWidget(
      {Key? key,
      required this.onClickedSignUp,
      required this.onClickedPassword})
      : super(key: key);

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final _userSignInFormKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                  key: _userSignInFormKey,
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
                              'Welcome',
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w900,
                                fontSize: 32.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          textFormField(
                            emailController,
                            TextInputType.emailAddress,
                            'Email',
                            'walterwhite@gmail.com',
                            validator: (email) {
                              email != null && !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null;
                              return null;
                            },
                          ),
                          textFormField(
                            passwordController,
                            TextInputType.phone,
                            'Password',
                            'Atleast 6 characters',
                            validator: (value) {
                              value != null && value.length < 6
                                  ? 'Enter minimum 6 characters'
                                  : null;
                              return null;
                            },
                            obscureText: _obscureText,
                            suffixIcon: IconButton(
                              splashRadius: 0.1,
                              color: kContainerColour,
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: _toggle,
                            ),
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
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = widget.onClickedPassword,
                                        text: 'Forgot Password?',
                                        style: const TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: kContainerColour,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              signIn();
                              // debugPrint('${emailController.text}j');
                              // globals.email = emailController.text;
                              // UserInformation().email = 'iohii';
                              // UserInformation().email = EemailController.text;
                              // debugPrint(UserInformation().email);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kButtonColour,
                              // padding: const EdgeInsets.symmetric(
                              //     vertical: 20.0, horizontal: 85.0),
                              shadowColor: kIconColour,
                              surfaceTintColor: kButtonColour,
                              fixedSize: Size(
                                MediaQuery.of(context).size.width / 2,
                                MediaQuery.of(context).size.height / 18,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // side: const BorderSide(color: Colors.black),
                              ),
                              elevation: 20.0,
                            ),
                            child: const Center(
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: kContainerColour,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                            child: Text(
                              'or',
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                color: kContainerColour,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                              final provider =
                                  Provider.of<GoogleSignInProvider>(context,
                                      listen: false);
                              provider.googleLogin();

                              debugPrint('${globals.name}k');
                              if (user != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const HomeScreen(),
                                  ),
                                );
                                navigatorKey.currentState!
                                    .popUntil((route) => route.isFirst);
                              }
                              // debugPrint(user!.displayName!.toString());
                              navigatorKey.currentState!
                                  .popUntil((route) => route.isFirst);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 18,
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kButtonColour,
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      height: 30.0,
                                      width: 30.0,
                                      // child: const FaIcon(
                                      //   FontAwesomeIcons.google,
                                      //   color: kContainerColour,
                                      // ),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage('images/google.png'),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const Text(
                                      'Sign in with Google',
                                      style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: kContainerColour,
                                      ),
                                    ),
                                  ],
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
                                        text: 'No Google Account? ',
                                        children: [
                                          TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = widget.onClickedSignUp,
                                            text: 'Sign Up',
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

  // signingoogle() async {
  //   await FirebaseServices().signInwithGoogle();
  // }

  Future signIn() async {
    final isValid = _userSignInFormKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      readPayer();
      debugPrint('${name}j');
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());

      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
