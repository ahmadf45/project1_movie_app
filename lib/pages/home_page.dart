import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1_movie_app/bloc/bloc_auth.dart';
import 'package:project1_movie_app/bloc/bloc_movie.dart';
import 'package:project1_movie_app/models/movie_model.dart';
import 'package:project1_movie_app/models/new_model.dart';
import 'package:project1_movie_app/widgets/movie_card.dart';

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
        title: const Text("Movies"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: screenSize.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("DATA"),
            FutureBuilder<NewModel?>(
              future: MovieClass().getTopRated(context, page),
              builder: (context, state) {
                if (state.connectionState == ConnectionState.done) {
                  if (state.data!.results!.isEmpty) {
                    return const Text("DATA KSONG");
                  } else {
                    return Text(state.data!.results![0].originalTitle!);
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            MovieCard(),
            InkWell(
              onTap: () async {
                var res = await AuthClass().signOut();
                if (res) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              child: Container(
                padding: EdgeInsets.all(20),
                color: Colors.blue,
                child: const Text("BUTTON"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
