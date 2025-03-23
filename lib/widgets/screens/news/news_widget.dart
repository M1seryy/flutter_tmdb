import 'package:flutter/material.dart';
import 'package:movie_tmdb/domain/dataProvider/ProviderInherited.dart';
import 'package:movie_tmdb/widgets/screens/news/news_model.dart';
import 'package:movie_tmdb/widgets/screens/news/news_widget_free_to_watch.dart';
import 'package:movie_tmdb/widgets/screens/news/news_widget_loaderboards.dart';
import 'package:movie_tmdb/widgets/screens/news/news_widget_popular.dart';
import 'package:movie_tmdb/widgets/screens/news/news_widget_trailer.dart';
import 'package:movie_tmdb/widgets/screens/news/news_widget_trandings.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const NewsWidgetPopular(),
        const NewsWidgetFreeToWatch(),
        const NewsWidgetTrailers(),
        const NewsWidgetTrandings(),
        const NewsWidgetLeaderboards(),
      ],
    );
  }
}
