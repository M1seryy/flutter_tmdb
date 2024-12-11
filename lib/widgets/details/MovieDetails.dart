import 'package:flutter/material.dart';
import 'package:movie_tmdb/widgets/details/mainMovieInfo.dart';
import 'package:movie_tmdb/widgets/details/screenCast.dart';

class Moviedetails extends StatelessWidget {
  final int movieId;
  const Moviedetails({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Star Wars: The Bad Batch",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: ColoredBox(
        color: Color.fromRGBO(24, 23, 27, 1.0),
        child: ListView(
          children: [MainMovieInfo(), Screencast()],
        ),
      ),
    );
  }
}
