import 'package:flutter/material.dart';
import 'package:movie_tmdb/domain/api_client/api.dart';
import 'package:movie_tmdb/domain/dataProvider/ProviderInherited.dart';
import 'package:movie_tmdb/widgets/details/MovieDetailsModel.dart';

class Screencast extends StatelessWidget {
  const Screencast({super.key});

  @override
  Widget build(BuildContext context) {
    const castTextStyle = TextStyle(fontWeight: FontWeight.w600);

    return const ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              "Screen Cast",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 330,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Scrollbar(
                child: ActorList(castTextStyle: castTextStyle),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: TextButton(
                onPressed: null,
                child: Text(
                  "Full cast data",
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                )),
          )
        ],
      ),
    );
  }
}

class ActorList extends StatelessWidget {
  const ActorList({
    super.key,
    required this.castTextStyle,
  });

  final TextStyle castTextStyle;

  @override
  Widget build(BuildContext context) {
    final model = ModelProviderStateFull.watch<MovieDetailsModel>(context);
    var cast = model?.movieDetails?.credits.cast;
    if (cast == null || cast.isEmpty) return const SizedBox.shrink();
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cast.length,
        itemExtent: 120,
        itemBuilder: (context, index) {
          return ActorListItem(
            castTextStyle: castTextStyle,
            index: index,
          );
        });
  }
}

class ActorListItem extends StatelessWidget {
  final index;
  const ActorListItem({
    super.key,
    required this.castTextStyle,
    required this.index,
  });

  final TextStyle castTextStyle;

  @override
  Widget build(BuildContext context) {
    final model = ModelProviderStateFull.read<MovieDetailsModel>(context);
    final actor = model!.movieDetails!.credits.cast[index];
    final actorImage = actor.profilePath;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 390 / 219,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(width: 2, color: const Color.fromARGB(255, 0, 0, 0)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                Container(
                    child: actorImage != null
                        ? Image.network(api_client.posterUrl(actorImage))
                        : const SizedBox.shrink()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(maxLines: 4, actor.name, style: castTextStyle),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(maxLines: 4, actor.character, style: castTextStyle),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(maxLines: 4, "", style: castTextStyle),
                      const SizedBox(
                        height: 7,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
