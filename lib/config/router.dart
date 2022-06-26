import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project1_movie_app/pages/error_page.dart';
import 'package:project1_movie_app/pages/home_page.dart';
import 'package:project1_movie_app/pages/login_page.dart';
import 'package:project1_movie_app/pages/splash_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/login':
        return PageTransition(
            child: const LoginPage(), type: PageTransitionType.fade);
      case '/home':
        return PageTransition(
            child: const HomePage(), type: PageTransitionType.fade);
      default:
        return PageTransition(
            child: const ErrorPage(), type: PageTransitionType.fade);
    }
  }
}
