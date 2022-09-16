// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:project1_movie_app/config/helper.dart';

class AuthBloc extends Cubit<User?> {
  AuthBloc() : super(userAuth) {
    debugPrint("INITIAL STATE");
  }

  //bool successGetInitialUser = false;
  static User? userAuth = FirebaseAuth.instance.currentUser;

  // Future<User?> initialUserAuth() async {
  //   try {
  //     final User? tempUser = FirebaseAuth.instance.currentUser;
  //     if (tempUser != null) {
  //       successGetInitialUser = true;
  //     } else {
  //       successGetInitialUser = true;
  //     }
  //     return tempUser;
  //   } catch (e) {
  //     successGetInitialUser = true;

  //     return null;
  //   }
  // }

  void signIn(
      BuildContext context, String emailAddress, String password) async {
    FirebaseAuth firebaseIntance = FirebaseAuth.instance;
    try {
      final credential = await firebaseIntance.signInWithEmailAndPassword(
          email: emailAddress, password: password);

      Helper().showLoading(context, true);
      if (credential.user != null) {
        Helper().showLoading(context, false);
      } else {
        Helper().showLoading(context, false);
      }
      emit(credential.user);
    } on FirebaseAuthException catch (e) {
      Helper().showLoading(context, false);
      if (e.code == 'user-not-found') {
        Helper().handlingError(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Helper()
            .handlingError(context, 'Wrong password provided for that user.');
      } else {
        Helper().handlingError(context, e.code);
      }
      return null;
    }
  }

  void signOut(BuildContext context) async {
    Helper().showLoading(context, true);
    try {
      await FirebaseAuth.instance.signOut();
      Helper().showLoading(context, false);
      emit(null);
    } catch (e) {
      print(e);
      Helper().handlingSuccess(context, 'Signout fail! Try again later.');
    }
  }
}
