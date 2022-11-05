import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locpay/screens/home_screen.dart';
import 'auth_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required onClickedSignUp}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final navigatorKey = GlobalKey<NavigatorState>();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong!'));
        } else if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}
// Future<FirebaseUser> signInWithGoogle(SignInViewModel model) async {
//   model.state =ViewState.Busy;
//   GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
//   GoogleSignInAuthentication googleSignInAuthentication =
//   await googleSignInAccount.authentication;
//   AuthCredential credential = GoogleAuthProvider.getCredential(
//     accessToken: googleSignInAuthentication.accessToken,
//     idToken: googleSignInAuthentication.idToken,
//   );
//   AuthResult authResult = await _auth.signInWithCredential(credential);
//   _user = authResult.user;
//   assert(!_user.isAnonymous);
//   assert(await _user.getIdToken() != null);
//   FirebaseUser currentUser = await _auth.currentUser();
//   assert(_user.uid == currentUser.uid);
//   model.state =ViewState.Idle;
//   print("User Name: ${_user.displayName}");
//   print("User Email ${_user.email}");
// }
//
