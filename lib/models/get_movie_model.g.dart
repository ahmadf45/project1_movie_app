// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMovieModel _$GetMovieModelFromJson(Map<String, dynamic> json) =>
    GetMovieModel(
      page: json['page'] as int,
      results: json['results'] as List<dynamic>,
      total_pages: json['total_pages'] as int,
      total_results: json['total_results'] as int,
    );

Map<String, dynamic> _$GetMovieModelToJson(GetMovieModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.total_pages,
      'total_results': instance.total_results,
    };
