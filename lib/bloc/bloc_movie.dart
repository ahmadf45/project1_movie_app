// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:project1_movie_app/models/new_model.dart';

class BlocMovie extends Cubit<NewModel?> {
  Dio dio = Dio();

  BlocMovie({this.init}) : super(init!);
  NewModel? init;
}

class MovieClass {
  Dio dio = Dio();

  Future<NewModel?> getTopRated(BuildContext context, int page) async {
    try {
      Response res = await dio.get(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=76885b738fab413af29618ee00c1967d&language=en-US&page=$page');
      inspect(res);
      if (res.statusCode == 200) {
        NewModel result = NewModel.fromJson(res.data);
        //inspect(result);
        return result;
      } else {
        print('Status Code : ${res.statusCode}');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
