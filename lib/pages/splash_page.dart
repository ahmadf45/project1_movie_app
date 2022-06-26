import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project1_movie_app/config/variables.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        print(user.uid);
        Future.delayed(const Duration(milliseconds: 1500), () async {
          await FirebaseAuth.instance.signOut();
          await EasyLoading.showSuccess(
            "Sign Out Successfull!",
            duration: const Duration(seconds: 1),
            dismissOnTap: false,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushReplacementNamed(context, "/login");
          });
        });
      } else {
        Future.delayed(const Duration(milliseconds: 1500), () {
          Navigator.pushReplacementNamed(context, "/login");
        });
      }
    });
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
