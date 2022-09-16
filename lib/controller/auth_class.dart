// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AuthController {
  Future<User?> signUpEmailPassword(
      String emailAddress, String password) async {
    FirebaseAuth firebaseIntance = FirebaseAuth.instance;
    await EasyLoading.show(
      status: 'Loading...',
      dismissOnTap: false,
    );
    try {
      final credential = await firebaseIntance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await EasyLoading.dismiss();
      await EasyLoading.showSuccess(
        "Sign Up Successfully.",
        duration: const Duration(
          seconds: 1,
        ),
        dismissOnTap: false,
      );

      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        await EasyLoading.showError('The password provided is too weak.',
            duration: const Duration(seconds: 1));
      } else if (e.code == 'email-already-in-use') {
        await EasyLoading.showError(
            'The account already exists for that email.',
            duration: const Duration(seconds: 1));
      } else {
        await EasyLoading.showError(e.code,
            duration: const Duration(seconds: 1));
      }
      return null;
    }
  }

  Future<User?> signInEmailPassword(
      String emailAddress, String password) async {
    FirebaseAuth firebaseIntance = FirebaseAuth.instance;
    await EasyLoading.show(
      status: 'Loading...',
      dismissOnTap: false,
    );

    try {
      final credential = await firebaseIntance.signInWithEmailAndPassword(
          email: emailAddress, password: password);

      await EasyLoading.dismiss();
      await EasyLoading.showSuccess(
        "Sign In Successfully.",
        duration: const Duration(seconds: 1),
        dismissOnTap: false,
      );
      inspect(credential);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await EasyLoading.showError('No user found for that email.',
            duration: const Duration(seconds: 1));
      } else if (e.code == 'wrong-password') {
        await EasyLoading.showError('Wrong password provided for that user.',
            duration: const Duration(seconds: 1));
      } else {
        await EasyLoading.showError(e.code,
            duration: const Duration(seconds: 1));
      }
      return null;
    }
  }

  Future<bool> registerNamePhone(User user, String name, String phone) async {
    await EasyLoading.show(
      status: 'Loading...',
      dismissOnTap: false,
    );

    try {
      await user.updateDisplayName(name);
      //await user.updatePhoneNumber(phoneCredential)
      await EasyLoading.dismiss();
      await EasyLoading.showSuccess(
        "Register Successfully.",
        duration: const Duration(seconds: 1),
        dismissOnTap: false,
      );
      return true;
    } catch (e) {
      await EasyLoading.showError('Register fail! Try again later.',
          duration: const Duration(seconds: 1));

      return false;
    }
  }

  Future<bool> signOut() async {
    await EasyLoading.show(
      status: 'Loading...',
      dismissOnTap: false,
    );
    try {
      await FirebaseAuth.instance.signOut();
      await EasyLoading.dismiss();
      await EasyLoading.showSuccess(
        "Sign Out Successfully.",
        duration: const Duration(seconds: 1),
        dismissOnTap: false,
      );
      return true;
    } catch (e) {
      print(e);
      await EasyLoading.showError('Signout fail! Try again later.',
          duration: const Duration(seconds: 1));
      return false;
    }
  }

  Future<bool> updatePhoto(File imageFile, String fileType) async {
    try {
      //FirebaseAuth.instance.currentUser!.updatePhotoURL(photoURL)
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final storageRef = FirebaseStorage.instance.ref();
      final userRef = storageRef.child("$userId.$fileType");
      var res = await userRef.putFile(imageFile);
      if (res.state == TaskState.success) {
        await FirebaseAuth.instance.currentUser!.updatePhotoURL(
            "gs://project365-d93e1.appspot.com/$userId.$fileType");
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (e) {
      inspect(e);
      return false;
    }
  }
}
