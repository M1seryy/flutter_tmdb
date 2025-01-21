import 'package:flutter/material.dart';
import 'package:movie_tmdb/widgets/navigation/mainNavigation.dart';

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

class Movielist extends StatefulWidget {
  const Movielist({super.key});

  @override
  State<Movielist> createState() => _MovielistState();
}

class _MovielistState extends State<Movielist> {
  final _searchController = TextEditingController();
  List<Movie> _filteredMovies = [];
  List<Movie> _movies = [
    Movie(
      id: 1,
      imageName:
          'https://thegalileo.co.za/wp-content/uploads/2024/09/The-Galileo-Open-Air-Cinema-Movie-inception-686x1030.webp',
      title: 'Inception',
      description:
          'A skilled thief is offered a chance to have his past crimes forgiven as payment for implanting another person\'s idea into a target\'s subconscious.',
      date: '2010-07-16',
    ),
    Movie(
      id: 2,
      imageName:
          'https://m.media-amazon.com/images/I/91vIHsL-zjL._AC_UF894,1000_QL80_.jpg',
      title: 'Interstellar',
      description:
          'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
      date: '2014-11-07',
    ),
    Movie(
      id: 3,
      imageName:
          'https://cdn.europosters.eu/image/1300/%D0%A4%D0%BE%D1%82%D0%BE%D1%88%D0%BF%D0%B0%D0%BB%D0%B5%D1%80%D0%B8/the-dark-knight-trilogy-joker-i184453.jpg',
      title: 'The Dark Knight',
      description:
          'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
      date: '2008-07-18',
    ),
    Movie(
      id: 4,
      imageName:
          'https://upload.wikimedia.org/wikipedia/ru/b/b3/%D0%90%D0%B2%D0%B0%D1%82%D0%B0%D1%80_%D0%9F%D1%83%D1%82%D1%8C_%D0%B2%D0%BE%D0%B4%D1%8B_%D0%BF%D0%BE%D1%81%D1%82%D0%B5%D1%80.jpg',
      title: 'Avatar',
      description:
          'A paraplegic Marine is dispatched to the moon Pandora on a unique mission, but becomes torn between following orders and protecting an alien civilization.',
      date: '2009-12-18',
    ),
    Movie(
      id: 5,
      imageName:
          'https://m.media-amazon.com/images/M/MV5BYWQ4YmNjYjEtOWE1Zi00Y2U4LWI4NTAtMTU0MjkxNWQ1ZmJiXkEyXkFqcGc@._V1_.jpg',
      title: 'Gladiator',
      description:
          'A former Roman General sets out to exact vengeance against the corrupt emperor who murdered his family and sent him into slavery.',
      date: '2000-05-05',
    ),
  ];

  @override
  void onSearchFilter() {
    final inputText = _searchController.text;
    if (inputText.isNotEmpty) {
      _filteredMovies = _movies.where((Movie item) {
        return item.title.toLowerCase().contains(inputText.toLowerCase());
      }).toList();
    } else {
      _filteredMovies = _movies;
    }
    setState(() {});
  }

  void initState() {
    onSearchFilter();
    _searchController.addListener(onSearchFilter);
  }

  void onMovieDetails(int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(MainNavRoutes.movieDetails, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
              padding: EdgeInsets.only(top: 80),
              itemExtent: 163,
              itemCount: _filteredMovies.length,
              itemBuilder: (BuildContext context, int index) {
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
                            Image(
                                height: 163,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    _filteredMovies[index].imageName)),
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
                                  _filteredMovies[index].title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _filteredMovies[index].date,
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
                                  _filteredMovies[index].description,
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
                            onMovieDetails(index);
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
                controller: _searchController,
                decoration: InputDecoration(
                  fillColor: Colors.white.withAlpha(235),
                  filled: true,
                  labelText: "Search",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                )),
          )
        ],
      ),
    );
  }
}
