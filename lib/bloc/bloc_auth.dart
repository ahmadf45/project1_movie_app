import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AuthClass {
  Future<bool> signUpEmailPassword(String emailAddress, String password) async {
    await EasyLoading.show(
      status: 'Loading...',
      dismissOnTap: false,
    );
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await EasyLoading.dismiss();
      await EasyLoading.showSuccess(
        "Sign Up Successfully!",
        duration: const Duration(
          seconds: 1,
        ),
        dismissOnTap: false,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        await EasyLoading.showError('The password provided is too weak.',
            duration: const Duration(seconds: 1));
      } else if (e.code == 'email-already-in-use') {
        await EasyLoading.showError(
            'The account already exists for that email.',
            duration: const Duration(seconds: 1));
      }
      return false;
    }
  }

  signInEmailPassword(String emailAddress, String password) async {
    await EasyLoading.show(
      status: 'Loading...',
      dismissOnTap: false,
    );
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      await EasyLoading.dismiss();
      await EasyLoading.showSuccess(
        "Sign In Successfully!",
        duration: const Duration(seconds: 1),
        dismissOnTap: false,
      );
      inspect(credential);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await EasyLoading.showError('No user found for that email.',
            duration: const Duration(seconds: 1));
      } else if (e.code == 'wrong-password') {
        await EasyLoading.showError('Wrong password provided for that user.',
            duration: const Duration(seconds: 1));
      }
      return false;
    }
  }

  signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }
}
