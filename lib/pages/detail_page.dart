// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1_movie_app/config/helper.dart';
import 'package:project1_movie_app/config/variables.dart';
import 'package:project1_movie_app/controller/movie_class.dart';
import 'package:project1_movie_app/models/detail_video_model.dart';
import 'package:project1_movie_app/models/popular_model.dart';
import 'package:project1_movie_app/models/top_rated_model.dart';
import 'package:project1_movie_app/models/video_caster_model.dart';
import 'package:project1_movie_app/models/video_model.dart';
import 'package:project1_movie_app/pages/player_page.dart';
import 'package:project1_movie_app/widgets/caster_card.dart';
import 'package:project1_movie_app/widgets/shimmering_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _isLiked = false;

  _getVideos() async {
    var res = await MovieController().getVideos(
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
    var res = await MovieController().getDetailVideos(
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
      _getLiked();
    }
  }

  _getVideoCaster() async {
    var res = await MovieController().getVideoCaster(
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

  _getLiked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String likesVideo = prefs.getString("likesVideo") ?? '';
    if (likesVideo != '') {
      Map<String, dynamic> jsonFile = jsonDecode(likesVideo);
      List<DetailVideoModel?> listFile = [];

      //find userId from saved json
      if (jsonFile.containsKey(userId)) {
        if (jsonFile[userId].length > 0) {
          for (var i = 0; i < jsonFile[userId].length; i++) {
            var ff = DetailVideoModel.fromJson(jsonFile[userId][i]);
            listFile.add(ff);
          }
          var isContain = (listFile.singleWhere(
                  (it) => it!.id == _detailVideo!.id,
                  orElse: () => null)) !=
              null;
          if (isContain) {
            setState(() {
              _isLiked = true;
            });
          }
        }
      }
    }
  }

  _functionLike() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String likesVideo = prefs.getString("likesVideo") ?? '';
    if (likesVideo == '') {
      var newJson = {};
      newJson[userId] = [];
      newJson[userId].add(_detailVideo);
      //inspect(newJson);
      var savingJson = jsonEncode(newJson);
      prefs.setString('likesVideo', savingJson);
    } else {
      Map<String, dynamic> jsonFile = jsonDecode(likesVideo);
      List<DetailVideoModel?> listFile = [];
      if (jsonFile[userId].length > 0) {
        for (var i = 0; i < jsonFile[userId].length; i++) {
          var ff = DetailVideoModel.fromJson(jsonFile[userId][i]);
          listFile.add(ff);
        }
      }
      var isContain = (listFile.singleWhere((it) => it!.id == _detailVideo!.id,
              orElse: () => null)) !=
          null;
      if (isContain == false) {
        listFile.add(_detailVideo);
      } else {
        await EasyLoading.showError('Already Liked',
            duration: const Duration(seconds: 1));
      }
      jsonFile[userId] = listFile;
      //inspect(jsonFile);
      var savingJson = jsonEncode(jsonFile);
      prefs.setString('likesVideo', savingJson);
    }
    _getLiked();
  }

  _functionUnlike() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String likesVideo = prefs.getString("likesVideo") ?? '';
    if (likesVideo != '') {
      Map<String, dynamic> jsonFile = jsonDecode(likesVideo);
      List<DetailVideoModel?> listFile = [];
      if (jsonFile[userId].length > 0) {
        for (var i = 0; i < jsonFile[userId].length; i++) {
          var ff = DetailVideoModel.fromJson(jsonFile[userId][i]);
          listFile.add(ff);
        }
      }
      listFile.removeWhere((element) => element!.id == _detailVideo!.id);
      jsonFile[userId] = listFile;
      //inspect(jsonFile);
      var savingJson = jsonEncode(jsonFile);
      prefs.setString('likesVideo', savingJson);
      setState(() {
        _isLiked = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print(
        'videoId : ${widget.movieType == 'popular' ? widget.popularResults!.id : widget.topRatedResults!.id}');
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
                                  : const GenreShimmer(),
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
                                  : const DurationRatingShimmer(),
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
                padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
                width: screenSize.width,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            if (_detailVideo != null) {
                              if (_isLiked) {
                                print("_functionUnlike");
                                _functionUnlike();
                              } else {
                                _functionLike();
                              }
                            }
                          },
                          child: Icon(
                            Icons.favorite,
                            color: _isLiked ? primaryColor : Colors.white,
                          ))
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
