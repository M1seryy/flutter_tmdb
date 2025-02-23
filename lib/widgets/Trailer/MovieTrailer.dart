import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MovieTrailer extends StatefulWidget {
  final trailerKey;
  const MovieTrailer({super.key, required this.trailerKey});
  @override
  State<MovieTrailer> createState() => _MovieTrailerState();
}

class _MovieTrailerState extends State<MovieTrailer> {
  // ignore: prefer_typing_uninitialized_variables
  late final _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.trailerKey,
      autoPlay: true,
      // params: const YoutubePlayerParams(showFullscreenButton: true),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Trailer",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: YoutubePlayer(
        controller: _controller,
        aspectRatio: 16 / 9,
      ),
    );
  }
}
