// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1_movie_app/config/helper.dart';
import 'package:project1_movie_app/config/variables.dart';
import 'package:project1_movie_app/controller/movie_class.dart';
import 'package:project1_movie_app/models/popular_model.dart';
import 'package:project1_movie_app/models/top_rated_model.dart';
import 'package:project1_movie_app/widgets/movie_card.dart';
import 'package:project1_movie_app/widgets/shimmering_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 1;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Movie App",
          style: GoogleFonts.nunitoSans(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: screenSize.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Movies",
                    style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: primaryTextColor,
                  )
                ],
              ),
              const SizedBox(height: 10),
              FutureBuilder<PopularModel?>(
                future: MovieController().getPopular(context, page),
                builder: (context, sstate) {
                  if (sstate.connectionState == ConnectionState.done) {
                    if (sstate.data!.results!.isEmpty) {
                      return SizedBox(
                          width: screenSize.width,
                          height: screenSize.width * 0.35 / 35 * 50 + 20,
                          child: const Text("DATA KSONG"));
                    } else {
                      return SizedBox(
                        width: screenSize.width,
                        height: screenSize.width * 0.35 / 35 * 50 + 20,
                        child: ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: ListView.builder(
                            itemCount: sstate.data!.results!.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return PopularMovieCard(
                                  result: sstate.data!.results![index]);
                            },
                          ),
                        ),
                      );
                    }
                  } else {
                    return SizedBox(
                      width: screenSize.width,
                      height: screenSize.width * 0.35 / 35 * 50 + 20,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: const [
                          MovieCardShimmer(),
                          MovieCardShimmer(),
                          MovieCardShimmer(),
                          MovieCardShimmer(),
                        ],
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Rated Movies",
                    style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: primaryTextColor,
                  )
                ],
              ),
              const SizedBox(height: 10),
              FutureBuilder<TopRatedModel?>(
                future: MovieController().getTopRated(context, page),
                builder: (context, state) {
                  if (state.connectionState == ConnectionState.done) {
                    if (state.data!.results!.isEmpty) {
                      return SizedBox(
                          width: screenSize.width,
                          height: screenSize.width * 0.35 / 35 * 50 + 20,
                          child: const Text("DATA KSONG"));
                    } else {
                      return SizedBox(
                        width: screenSize.width,
                        height: screenSize.width * 0.35 / 35 * 50 + 20,
                        child: ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: ListView.builder(
                            itemCount: state.data!.results!.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return TopRatedMovieCard(
                                  result: state.data!.results![index]);
                            },
                          ),
                        ),
                      );
                    }
                  } else {
                    return SizedBox(
                      width: screenSize.width,
                      height: screenSize.width * 0.35 / 35 * 50 + 20,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: const [
                          MovieCardShimmer(),
                          MovieCardShimmer(),
                          MovieCardShimmer(),
                          MovieCardShimmer(),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
