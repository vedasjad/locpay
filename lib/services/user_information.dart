import 'package:flutter/material.dart';
import 'package:locpay/services/globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInformation {
  var email;
  var name;
}

class StringProvider extends ChangeNotifier {
  // create a common file for data
  String _str = 'hello';

  String get str => _str;

  void setString(String st) {
    _str = st;
    notifyListeners();
  }
}

var name;
void readPayer() async {
  debugPrint("${globals.name}a");
  globals.email = FirebaseAuth.instance.currentUser!.email.toString();
  debugPrint("${globals.email}z");
  // UserInformation().name = getName().toString();

  final docPayer =
      FirebaseFirestore.instance.collection('users').doc(globals.email);
  final snapshot = await docPayer.get();

  if (snapshot.exists) {
    // debugPrint("${globals.name}b");
    globals.name = snapshot['name'].toString();
    debugPrint(snapshot['name']);
    debugPrint("${globals.name}c");
  }
  return null;
}
