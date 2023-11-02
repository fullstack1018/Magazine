// ignore_for_file: file_names, avoid_print

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:magazine/services/firebase/helper_function.dart';

class AuthenticationHelper {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  bool isLoggin = false;

  //SIGN UP METHOD
  Future signUp(
      {required String email,
      required String name,
      required Function onChange,
      required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (_auth.currentUser != null) {
        await _fireStore.collection("Users").doc(_auth.currentUser?.uid).set({
          "name": name,
          "email": email,
          "is_premium": false,
          "userID": generateRandomString(15),
          "password": password,
        });
        onChange(0);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    print("object: $email : $password");
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    HelperFunctions().clearPrefs();
    Get.offAllNamed("/login");
    await _auth.signOut();
  }
}

String generateRandomString(int len) {
  var r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}
