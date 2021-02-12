import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signup(String email, String password) async {
    try {
      UserCredential newuser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return newuser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserCredential> loginUsernamePassword(
      String email, String password) async {
    try {
      UserCredential _user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void logout() {
    _auth.signOut();
  }

  User logedcurrentUser() {
    try {
      User usr = _auth.currentUser;
      return usr;
    } catch (e) {
      return null;
    }
  }
}
