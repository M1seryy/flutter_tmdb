import 'package:flutter/material.dart';

class Movie {
  final String imageName;
  final String title;
  final String description;
  final String date;

  Movie({
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
  final List<Movie> _movies = [
    Movie(
      imageName: 'assets/images/inception.jpg',
      title: 'Inception',
      description:
          'A skilled thief is offered a chance to have his past crimes forgiven as payment for implanting another person\'s idea into a target\'s subconscious.',
      date: '2010-07-16',
    ),
    Movie(
      imageName: 'assets/images/interstellar.jpg',
      title: 'Interstellar',
      description:
          'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
      date: '2014-11-07',
    ),
    Movie(
      imageName: 'assets/images/the_dark_knight.jpg',
      title: 'The Dark Knight',
      description:
          'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
      date: '2008-07-18',
    ),
    Movie(
      imageName: 'assets/images/avatar.jpg',
      title: 'Avatar',
      description:
          'A paraplegic Marine is dispatched to the moon Pandora on a unique mission, but becomes torn between following orders and protecting an alien civilization.',
      date: '2009-12-18',
    ),
    Movie(
      imageName: 'assets/images/gladiator.jpg',
      title: 'Gladiator',
      description:
          'A former Roman General sets out to exact vengeance against the corrupt emperor who murdered his family and sent him into slavery.',
      date: '2000-05-05',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemExtent: 163,
          itemCount: _movies.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                                "https://posterhouse.org/wp-content/uploads/2021/05/moonlight_0.jpg")),
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
                              _movies[index].title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _movies[index].date,
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
                              _movies[index].description,
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
                        print("Movie card TAP");
                      },
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
