import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1_movie_app/bloc/bloc_movie.dart';
import 'package:project1_movie_app/models/movie_model.dart';
import 'package:project1_movie_app/models/new_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME PAGE"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("DATA"),
            FutureBuilder<NewModel?>(
              future: MovieClass().getTopRated(context),
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
            InkWell(
              onTap: () {
                MovieClass().getTopRated(context);
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
