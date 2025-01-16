import 'package:flutter/material.dart';
import 'package:movie_tmdb/Theme/app_images.dart';
import 'package:movie_tmdb/widgets/PaintCircle.dart';

class NewsWidgetFreeToWatch extends StatefulWidget {
  const NewsWidgetFreeToWatch({Key? key}) : super(key: key);

  @override
  _NewsWidgetFreeToWatchState createState() => _NewsWidgetFreeToWatchState();
}

class _NewsWidgetFreeToWatchState extends State<NewsWidgetFreeToWatch> {
  final _catrgory = 'movies';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Free To Watch',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              DropdownButton<String>(
                value: _catrgory,
                onChanged: (catrgory) {},
                items: [
                  const DropdownMenuItem(
                      value: 'movies', child: Text('Movies')),
                  const DropdownMenuItem(value: 'tv', child: Text('TV')),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 320,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemExtent: 150,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: const Image(
                              image: NetworkImage(AppImages.moviePlacholder),
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
                        const Positioned(
                          left: 10,
                          bottom: 0,
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Paintcircle(
                              percentage: 0.68,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: Text(
                        'Willy`s Wonderland',
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
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
