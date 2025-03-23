import 'package:flutter/material.dart';
import 'package:movie_tmdb/Theme/app_images.dart';
import 'package:movie_tmdb/domain/api_client/api.dart';
import 'package:movie_tmdb/domain/dataProvider/ProviderInherited.dart';
import 'package:movie_tmdb/widgets/PaintCircle.dart';
import 'package:movie_tmdb/widgets/movieList/movie_list_model.dart';
import 'package:movie_tmdb/widgets/screens/news/news_model.dart';

class NewsWidgetPopular extends StatefulWidget {
  const NewsWidgetPopular({Key? key}) : super(key: key);

  @override
  _NewsWidgetPopularState createState() => _NewsWidgetPopularState();
}

class _NewsWidgetPopularState extends State<NewsWidgetPopular> {
  final _catrgory = 'movies';
  @override
  Widget build(BuildContext context) {
    final model = ModelProviderStateFull.watch<NewsModel>(context);
    final api = api_client();
    print(model?.popularMovies?.movies.length);

    return model == null
        ? SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'What`s Popular',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    DropdownButton<String>(
                      value: _catrgory,
                      onChanged: (catrgory) {},
                      items: [
                        const DropdownMenuItem(
                            value: 'movies', child: Text('Movies')),
                        const DropdownMenuItem(value: 'tv', child: Text('TV')),
                        const DropdownMenuItem(
                            value: 'tvShows', child: Text('TVShows')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 306,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: model.popularMovies?.movies.length ?? 0,
                  itemExtent: 145,
                  itemBuilder: (BuildContext context, int index) {
                    final imagePath =
                        model.popularMovies?.movies[index].poster_path;
                    final movie = model.popularMovies?.movies[index];
                    final title = movie?.title ?? 'No Title';
                    final score = movie!.popularity / 1000;
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ColoredBox(
                            color: Colors.black,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image(
                                      image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500$imagePath'),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 15,
                                  right: 15,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Icon(Icons.more_horiz),
                                  ),
                                ),
                                Positioned(
                                  left: 10,
                                  bottom: 0,
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Paintcircle(
                                      percentage: score,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, top: 10, right: 10),
                            child: Text(
                              title,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 10, top: 10, right: 10),
                            child: Text('Feb 12, 2021'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
