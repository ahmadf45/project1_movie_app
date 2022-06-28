// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1_movie_app/bloc/bloc_auth.dart';
import 'package:project1_movie_app/config/variables.dart';

class RegisterPage extends StatefulWidget {
  final User user;
  const RegisterPage({Key? key, required this.user}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final focusName = FocusNode();
  final focusPhone = FocusNode();

  _register() async {
    if (_nameController.text == '') {
      FocusScope.of(context).requestFocus(focusName);
    } else if (_phoneController.text == '') {
      FocusScope.of(context).requestFocus(focusPhone);
    } else {
      var res = await AuthClass().registerNamePhone(
          widget.user, _nameController.text, _phoneController.text);
      if (res) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    inspect(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
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
                  width: screenSize.width * 0.5,
                  child: FittedBox(
                    child: Text(
                      "Haii,",
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "register your data to continue watching.",
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
                            cursorColor: primaryColor,
                            focusNode: focusName,
                            keyboardType: TextInputType.text,
                            controller: _nameController,
                            textInputAction: TextInputAction.next,
                            style: GoogleFonts.nunitoSans(
                                color: primaryTextColor,
                                fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                              hintText: 'Your Name',
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
                                  borderSide: BorderSide(color: primaryColor)),
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
                              _register();
                            },
                            cursorColor: primaryColor,
                            focusNode: focusPhone,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.go,
                            controller: _phoneController,
                            style: GoogleFonts.nunitoSans(
                                color: primaryTextColor,
                                fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                              hintText: 'Your phone number',
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
                                  borderSide: BorderSide(color: primaryColor)),
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
                    _register();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(500),
                    ),
                    child: Center(
                      child: Text(
                        "REGISTER",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
