// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project1_movie_app/bloc/auth_bloc.dart';
import 'package:project1_movie_app/config/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    if (authBloc.state != null) {
      print(authBloc.state!.uid);
      Future.delayed(const Duration(milliseconds: 1500), () async {
        if (authBloc.state!.displayName != null) {
          Navigator.pushReplacementNamed(context, "/home");
        } else {
          dynamic param = ({
            "user": authBloc.state,
          });
          Navigator.pushReplacementNamed(context, '/register',
              arguments: param);
        }
      });
    } else {
      print("User not logged in");
      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.pushReplacementNamed(context, "/login");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Image.asset(
            "assets/images/logo2.png",
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
