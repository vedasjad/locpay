import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:locpay/services/user_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locpay/services/globals.dart' as globals;
import 'firebase_database.dart';

Future createPayer(Payer user) async {
  final docUser = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.email);

  final json = user.toJson();

  await docUser.set(json);
}

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && user.displayName != null) {
        if (user.displayName != null) {
          final user = Payer(
            name: FirebaseAuth.instance.currentUser!.displayName.toString(),
            email: FirebaseAuth.instance.currentUser!.email.toString(),
          );
          createPayer(user);
          globals.name =
              FirebaseAuth.instance.currentUser!.displayName.toString();
          globals.email = FirebaseAuth.instance.currentUser!.email.toString();
        } else {}
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
