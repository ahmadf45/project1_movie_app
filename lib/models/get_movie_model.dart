import 'package:json_annotation/json_annotation.dart';

part 'get_movie_model.g.dart';

@JsonSerializable()
class GetMovieModel {
  final int page;
  final List<dynamic> results;
  final int total_pages;
  final int total_results;

  GetMovieModel(
      {required this.page,
      required this.results,
      required this.total_pages,
      required this.total_results});

  factory GetMovieModel.fromMap(Map<String, dynamic> data) =>
      _$GetMovieModelFromJson(data);
}
