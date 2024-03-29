// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1_movie_app/config/variables.dart';
import 'package:project1_movie_app/controller/auth_class.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final focusEmail = FocusNode();
  final focusPassword = FocusNode();

  _signIn() async {
    if (_emailController.text == '') {
      FocusScope.of(context).requestFocus(focusEmail);
    } else if (_passwordController.text == '') {
      FocusScope.of(context).requestFocus(focusPassword);
    } else {
      final bool emailIsValid = EmailValidator.validate(_emailController.text);
      if (emailIsValid) {
        final user = await AuthController().signInEmailPassword(
            _emailController.text, _passwordController.text);
        if (user != null) {
          if (user.displayName != null) {
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            dynamic param = ({
              "user": user,
            });
            Navigator.pushReplacementNamed(context, '/register',
                arguments: param);
          }
        }
      } else {
        EasyLoading.showError(
          'Invalid Email',
          duration: const Duration(milliseconds: 1000),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    DateTime pre_backpress = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        if (Platform.isAndroid) {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= const Duration(seconds: 1);
          pre_backpress = DateTime.now();
          if (cantExit) {
            //show snackbar
            EasyLoading.showToast("Press Back button again to Exit",
                toastPosition: EasyLoadingToastPosition.bottom,
                duration: const Duration(seconds: 1));
            return false; // false will do nothing when back press
          } else {
            return true; // true will exit the app
          }
        } else {
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width * 0.3,
                    child: Image.asset("assets/images/logo2.png"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: screenSize.width * 0.7,
                    child: FittedBox(
                      child: Text(
                        "Welcome Back,",
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "sign in to continue watching.",
                      style: GoogleFonts.nunitoSans(),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromARGB(255, 122, 122, 122),
                              ),
                            ),
                          ),
                          child: SizedBox(
                            width: screenSize.width,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email cant be null';
                                }
                                return null;
                              },
                              focusNode: focusEmail,
                              cursorColor: primaryColor,
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              textInputAction: TextInputAction.next,
                              style: GoogleFonts.nunitoSans(
                                  color: primaryTextColor,
                                  fontWeight: FontWeight.w700),
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: GoogleFonts.nunitoSans(
                                    color: primaryTextColor,
                                    fontWeight: FontWeight.normal),
                                border: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white12)),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white12)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: primaryColor)),
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                errorStyle: const TextStyle(color: Colors.pink),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromARGB(255, 122, 122, 122),
                              ),
                            ),
                          ),
                          child: SizedBox(
                            width: screenSize.width,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password cant be null';
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                _signIn();
                              },
                              cursorColor: primaryColor,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.go,
                              controller: _passwordController,
                              obscureText: true,
                              style: GoogleFonts.nunitoSans(
                                  color: primaryTextColor,
                                  fontWeight: FontWeight.w700),
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: GoogleFonts.nunitoSans(
                                    color: primaryTextColor,
                                    fontWeight: FontWeight.normal),
                                border: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white12)),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white12)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: primaryColor)),
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                errorStyle: const TextStyle(color: Colors.pink),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      _signIn();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(500),
                      ),
                      child: Center(
                        child: Text(
                          "LOGIN",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "sign up,",
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w800,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                    context, '/signUp');
                              },
                          ),
                          const TextSpan(
                            text: " if you're new.",
                          )
                        ],
                        style: GoogleFonts.nunitoSans(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
