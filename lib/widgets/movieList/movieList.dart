import 'package:flutter/material.dart';
import 'package:movie_tmdb/domain/api_client/api.dart';
import 'package:movie_tmdb/domain/dataProvider/ProviderInherited.dart';
import 'package:movie_tmdb/widgets/movieList/movie_list_model.dart';
import 'package:movie_tmdb/widgets/navigation/mainNavigation.dart';
import 'package:intl/intl.dart';

class Movie {
  final int id;
  final String imageName;
  final String title;
  final String description;
  final String date;

  Movie({
    required this.id,
    required this.imageName,
    required this.title,
    required this.description,
    required this.date,
  });
}

class Movielist extends StatelessWidget {
  Movielist({super.key});
  List<Movie> _filteredMovies = [];

  @override
  Widget build(BuildContext context) {
    final model = ModelProvider.watch<MovieListModel>(context);
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
              padding: EdgeInsets.only(top: 80),
              itemExtent: 163,
              itemCount: model?.movieList.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final currentMovie = model?.movieList[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Stack(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(255, 53, 52, 52)
                                    .withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(2, 8))
                          ],
                        ),
                        child: Row(
                          children: [
                            // Image(
                            // height: 163,
                            // fit: BoxFit.cover,
                            Image.network(
                              width: 95,
                              currentMovie?.poster_path != null
                                  ? api_client.posterUrl(
                                      (currentMovie!.poster_path).toString())
                                  : "https://via.placeholder.com/500", // Замінник для порожнього зображення
                              height: 163,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Text(
                                    'Помилка завантаження'); // Текст при помилці
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  currentMovie != null
                                      ? currentMovie.title.toString()
                                      : "title",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  currentMovie != null
                                      ? model!.dateTimeParser(
                                          currentMovie.release_date as DateTime)
                                      : "date",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  currentMovie != null
                                      ? currentMovie.overview
                                      : "date",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            )),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            model?.onMovieTap(context, index);
                          },
                        ),
                      )
                    ],
                  ),
                );
              }),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
                // controller: _searchController,
                decoration: InputDecoration(
              fillColor: Colors.white.withAlpha(235),
              filled: true,
              labelText: "Search",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            )),
          )
        ],
      ),
    );
  }
}
