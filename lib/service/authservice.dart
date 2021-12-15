import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:herewego/pages/sing_in_page.dart';
import 'package:herewego/service/prefs.dart';

class AuthService {
  static final _Auth = FirebaseAuth.instance;
  // create method
  static Future<User> SignInUser(
      BuildContext context, String email, String password) async {
    try {
      var result = await _Auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = await result.user;
      print(user?.uid);
      return user!;
    } catch (e) {
      print(e);
    }
    var empty;
    return empty;
  }

  // load method
  static Future<User> SignUpUser(
      BuildContext context, String email, String password) async {
    try {
      var result = await _Auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = await result.user;
      
      print(user?.uid);
      return user!;
    } catch (e) {
      print(e);
    }
    var empty;
    return empty;
  }

  // delete method
  static void Loguot(BuildContext context) async {
    _Auth.signOut();
    Prefs.DeleteUserId().then(
        (value) => Navigator.pushReplacementNamed(context, SignInPage().id));
  }
}
