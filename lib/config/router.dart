import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project1_movie_app/pages/detail_page.dart';
import 'package:project1_movie_app/pages/error_page.dart';
import 'package:project1_movie_app/pages/home_page.dart';
import 'package:project1_movie_app/pages/login_page.dart';
import 'package:project1_movie_app/pages/register_page.dart';
import 'package:project1_movie_app/pages/sign_up_page.dart';
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
      case '/signUp':
        return PageTransition(
            child: const SignUpPage(), type: PageTransitionType.fade);
      case '/register':
        dynamic param = args;
        return PageTransition(
            child: RegisterPage(
              user: param['user'],
            ),
            type: PageTransitionType.fade);
      case '/home':
        return PageTransition(
            child: const HomePage(), type: PageTransitionType.fade);
      case '/detail':
        dynamic param = args;
        return PageTransition(
            child: DetailPage(
              movieType: param['movieType'],
              popularResults: param['popularResults'],
              topRatedResults: param['topRatedResults'],
            ),
            type: PageTransitionType.fade);
      default:
        return PageTransition(
            child: const ErrorPage(), type: PageTransitionType.fade);
    }
  }
}
