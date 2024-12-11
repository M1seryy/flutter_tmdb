import 'package:flutter/material.dart';
import 'package:movie_tmdb/widgets/PaintCircle.dart';

class MainMovieInfo extends StatelessWidget {
  const MainMovieInfo({super.key});

  @override
  Widget build(BuildContext context) {
    const baseImagePath = 'https://image.tmdb.org/t/p/original';
    const backDropPath = '/abwxHfymXGAbbH3lo9PDEJEfvtW.jpg';
    const posterImage = '/oZNPzxqM2s5DyVWab09NTQScDQt.jpg';
    return Column(
      children: [
        _PosterWidget(
            baseImagePath: baseImagePath,
            backDropPath: backDropPath,
            posterImage: posterImage),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: TextWidget(),
        ),
        RatingWidget(),
        SummaryText(),
        SizedBox(
          height: 10,
        ),
        OverviewWidget(),
        SizedBox(
          height: 20,
        ),
        PeopleInfoWidget(),
      ],
    );
  }
}

class _PosterWidget extends StatelessWidget {
  const _PosterWidget({
    required this.baseImagePath,
    required this.backDropPath,
    required this.posterImage,
  });

  final String baseImagePath;
  final String backDropPath;
  final String posterImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: Image(
            image: NetworkImage('$baseImagePath$backDropPath'),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30, left: 10),
          width: 100,
          child: Image(image: NetworkImage('$baseImagePath$posterImage')),
        ),
      ],
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      maxLines: 3,
      text: const TextSpan(children: [
        TextSpan(
            text: "Star Wars: The Bad Batch",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 21)),
        TextSpan(
            text: "  (2021)",
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey))
      ]),
    );
  }
}

class SummaryText extends StatelessWidget {
  const SummaryText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
      child: ColoredBox(
        color: Color.fromRGBO(22, 21, 25, 1.0),
        child: Text(
          textAlign: TextAlign.center,
          'PG-13 24/10/2024 (UA) Action, Science Fiction, Adventure 1h 49m',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class PeopleInfoWidget extends StatelessWidget {
  const PeopleInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final jobStyle =
        TextStyle(fontWeight: FontWeight.w500, color: Colors.white);

    final actorStyle =
        TextStyle(fontWeight: FontWeight.w800, color: Colors.white);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kelly Marcel", style: actorStyle),
                    Text(
                      "Director, Screenplay, Story",
                      style: jobStyle,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "David Michelinie",
                    style: actorStyle,
                  ),
                  Text(
                    "Characters",
                    style: jobStyle,
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Todd McFarlane ",
                      style: actorStyle,
                    ),
                    Text(
                      "Characters",
                      style: jobStyle,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Tom Hardy",
                    style: actorStyle,
                  ),
                  Text(
                    "Story",
                    style: jobStyle,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Eddie and Venom are on the run. Hunted by both of their worlds and with the net closing in, the duo are forced into a devastating decision that will bring the curtains down on Venom and Eddie's last dance.",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: null,
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                child: Paintcircle(
                  percentage: 0.72,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "User score",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        Container(
          width: 1,
          height: 20,
          color: Colors.grey,
        ),
        Row(
          children: [
            Icon(Icons.play_arrow),
            SizedBox(
              width: 20,
            ),
            Text(
              "Play trailer",
              style: TextStyle(color: Colors.white),
            ),
          ],
        )
      ],
    );
  }
}
