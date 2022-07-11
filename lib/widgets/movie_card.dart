import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project1_movie_app/config/variables.dart';
import 'package:project1_movie_app/models/popular_model.dart';
import 'package:project1_movie_app/models/top_rated_model.dart';
import 'package:shimmer/shimmer.dart';

class PopularMovieCard extends StatelessWidget {
  final PopularResults result;
  const PopularMovieCard({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        dynamic param = ({"movieType": 'popular', "popularResults": result});
        Navigator.pushNamed(context, '/detail', arguments: param);
      },
      child: Container(
        width: screenSize.width * 0.35,
        height: screenSize.width * 0.35 / 35 * 50,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${result.posterPath}',
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Color.fromARGB(255, 182, 180, 180),
            highlightColor: Color.fromARGB(255, 139, 139, 139),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center()),
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.error,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}

class TopRatedMovieCard extends StatelessWidget {
  final TopRatedResults result;
  const TopRatedMovieCard({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        dynamic param = ({"movieType": 'topRated', "topRatedResults": result});
        Navigator.pushNamed(context, '/detail', arguments: param);
      },
      child: Container(
        width: screenSize.width * 0.35,
        height: screenSize.width * 0.35 / 35 * 50,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${result.posterPath}',
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Color.fromARGB(255, 182, 180, 180),
            highlightColor: Color.fromARGB(255, 139, 139, 139),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center()),
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.error,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
