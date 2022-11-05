import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  signIn(String email, String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      assert(user != null);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      rethrow;
    }
  }

  signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await _auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      rethrow;
    }
  }

  googlesignOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
