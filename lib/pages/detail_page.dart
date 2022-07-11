import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1_movie_app/bloc/bloc_movie.dart';
import 'package:project1_movie_app/config/helper.dart';
import 'package:project1_movie_app/models/detail_video_model.dart';
import 'package:project1_movie_app/models/popular_model.dart';
import 'package:project1_movie_app/models/top_rated_model.dart';
import 'package:project1_movie_app/models/video_caster_model.dart';
import 'package:project1_movie_app/models/video_model.dart';
import 'package:project1_movie_app/pages/player_page.dart';
import 'package:project1_movie_app/widgets/caster_card.dart';
import 'package:project1_movie_app/widgets/shimmering_widgets.dart';

class DetailPage extends StatefulWidget {
  final String movieType;
  final PopularResults? popularResults;
  final TopRatedResults? topRatedResults;
  const DetailPage(
      {Key? key,
      required this.movieType,
      this.popularResults,
      this.topRatedResults})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  VideoModel? _videoModel;
  DetailVideoModel? _detailVideo;
  List<String?> _listGenre = [];
  VideoCasterModel? _videoCaster;

  _getVideos() async {
    var res = await MovieClass().getVideos(
        context,
        widget.movieType == 'popular'
            ? widget.popularResults!.id
            : widget.topRatedResults!.id);
    if (res != null) {
      setState(() {
        _videoModel = res;
      });
    }
  }

  _getDetail() async {
    var res = await MovieClass().getDetailVideos(
        context,
        widget.movieType == 'popular'
            ? widget.popularResults!.id
            : widget.topRatedResults!.id);

    if (res != null) {
      setState(() {
        _detailVideo = res;
        for (var i = 0; i < _detailVideo!.genres!.length; i++) {
          _listGenre.add(_detailVideo!.genres![i].name);
        }
      });
    }
  }

  _getVideoCaster() async {
    var res = await MovieClass().getVideoCaster(
        context,
        widget.movieType == 'popular'
            ? widget.popularResults!.id
            : widget.topRatedResults!.id);
    if (res != null) {
      setState(() {
        _videoCaster = res;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    inspect(widget.movieType == 'popular'
        ? widget.popularResults!.id
        : widget.topRatedResults!.id);

    _getVideos();
    _getDetail();
    _getVideoCaster();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenPadding = MediaQuery.of(context).padding;
    return Scaffold(
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: screenSize.width,
                    //height: 450,
                    color: Colors.black,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${widget.movieType == "popular" ? widget.popularResults!.backdropPath : widget.topRatedResults!.backdropPath}',
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    const Center(),
                            errorWidget: (context, url, error) => const Center(
                                child: Icon(
                              Icons.error,
                              size: 30,
                            )),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          color: Colors.black.withOpacity(0.7),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: screenPadding.top + 50,
                                    bottom: 10,
                                    left: screenSize.width * 0.25,
                                    right: screenSize.width * 0.25),
                                height: screenSize.width * 0.75,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/w500${widget.movieType == "popular" ? widget.popularResults!.posterPath : widget.topRatedResults!.posterPath}',
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                const Center(),
                                        errorWidget: (context, url, error) =>
                                            const Center(
                                                child: Icon(Icons.error)),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Center(
                                      child: IconButton(
                                        iconSize: 80,
                                        onPressed: () {
                                          if (_videoModel != null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlayerPage(
                                                          videoId: _videoModel!
                                                              .key
                                                              .toString())),
                                            );
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.play_circle_outline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                widget.movieType == 'popular'
                                    ? '${widget.popularResults!.title!} (${widget.popularResults!.releaseDate!.substring(0, 4)})'
                                    : '${widget.topRatedResults!.title!} (${widget.topRatedResults!.releaseDate!.substring(0, 4)})',
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              _listGenre.isNotEmpty
                                  ? SizedBox(
                                      width: screenSize.width * 0.8,
                                      child: Text(_listGenre.join(', '),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunitoSans(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                    )
                                  : Container(),
                              const SizedBox(height: 5),
                              _detailVideo != null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            Helper().durationToString(
                                                _detailVideo!.runtime),
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 15,
                                                color: Colors.grey)),
                                        const SizedBox(width: 20),
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 15,
                                        ),
                                        const SizedBox(width: 1),
                                        Text(
                                            _detailVideo!.voteAverage
                                                .toString(),
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 15,
                                                color: Colors.grey)),
                                      ],
                                    )
                                  : Container(),
                              const SizedBox(height: 20),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Movie Info",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 18, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        _detailVideo != null
                            ? Text(_detailVideo!.overview.toString())
                            : const DescriptionShimmer(),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Caster",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 18, color: Colors.white),
                        ),
                        _videoCaster != null
                            ? SizedBox(
                                height: 70,
                                child: ScrollConfiguration(
                                  behavior: MyBehavior(),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: _videoCaster!.cast!.length,
                                    itemBuilder: (context, i) {
                                      return CasterCard(
                                        url: _videoCaster!.cast![i].profilePath,
                                        gender: _videoCaster!.cast![i].gender
                                            .toString(),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 70,
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  children: const [
                                    CasterCardShimmer(),
                                    CasterCardShimmer(),
                                    CasterCardShimmer(),
                                    CasterCardShimmer(),
                                    CasterCardShimmer(),
                                    CasterCardShimmer(),
                                    CasterCardShimmer(),
                                    CasterCardShimmer(),
                                    CasterCardShimmer(),
                                    CasterCardShimmer(),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                margin: EdgeInsets.only(top: screenPadding.top),
                padding: const EdgeInsets.only(left: 20, top: 15),
                width: screenSize.width,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
