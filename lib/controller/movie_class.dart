// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:project1_movie_app/models/detail_video_model.dart';
import 'package:project1_movie_app/models/popular_model.dart';
import 'package:project1_movie_app/models/top_rated_model.dart';
import 'package:project1_movie_app/models/video_caster_model.dart';
import 'package:project1_movie_app/models/video_model.dart';

// class BlocMovie extends Cubit<NewModel?> {
//   Dio dio = Dio();

//   BlocMovie({this.init}) : super(init!);
//   NewModel? init;
// }

class MovieController {
  Dio dio = Dio();

  Future<PopularModel?> getPopular(BuildContext context, int page) async {
    try {
      Response res = await dio.get(
          'https://api.themoviedb.org/3/movie/popular?api_key=76885b738fab413af29618ee00c1967d&language=en-US&page=$page');
      //inspect(res);
      if (res.statusCode == 200) {
        PopularModel result = PopularModel.fromJson(res.data);
        //inspect(result);
        return result;
      } else {
        print('Status Code : ${res.statusCode}');
        return null;
      }
    } catch (e) {
      inspect(e);
      print("FAIL CALL GET POPULAR API");
      return null;
    }
  }

  Future<TopRatedModel?> getTopRated(BuildContext context, int page) async {
    try {
      Response res = await dio.get(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=76885b738fab413af29618ee00c1967d&language=en-US&page=$page');
      //inspect(res);
      if (res.statusCode == 200) {
        TopRatedModel result = TopRatedModel.fromJson(res.data);
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

  Future<VideoModel?> getVideos(BuildContext context, int? id) async {
    try {
      Response res = await dio.get(
          'https://api.themoviedb.org/3/movie/$id/videos?api_key=76885b738fab413af29618ee00c1967d&language=en-US');
      //inspect(res);
      if (res.statusCode == 200) {
        //inspect(res.data);
        if (res.data['results'].length > 0) {
          VideoModel result = VideoModel.fromJson(res.data['results'][0]);
          return result;
        } else {
          return null;
        }
      } else {
        print('Status Code : ${res.statusCode}');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<DetailVideoModel?> getDetailVideos(
      BuildContext context, int? id) async {
    try {
      Response res = await dio.get(
          'https://api.themoviedb.org/3/movie/$id?api_key=76885b738fab413af29618ee00c1967d&language=en-US');
      //inspect(res);
      if (res.statusCode == 200) {
        //inspect(res.data);
        try {
          DetailVideoModel result = DetailVideoModel.fromJson(res.data);
          //inspect(result);
          return result;
        } catch (ee) {
          print(ee);
          return null;
        }
      } else {
        print('Status Code : ${res.statusCode}');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<VideoCasterModel?> getVideoCaster(
      BuildContext context, int? id) async {
    try {
      Response res = await dio.get(
          'https://api.themoviedb.org/3/movie/$id/credits?api_key=76885b738fab413af29618ee00c1967d&language=en-US');
      //inspect(res);
      if (res.statusCode == 200) {
        //inspect(res.data);
        try {
          VideoCasterModel result = VideoCasterModel.fromJson(res.data);
          //inspect(result);
          return result;
        } catch (ee) {
          print(ee);
          return null;
        }
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
