import 'package:flutter/material.dart';
import 'package:movie_tmdb/Theme/app_images.dart';
import 'package:movie_tmdb/domain/dataProvider/ProviderInherited.dart';
import 'package:movie_tmdb/domain/dataProvider/sessionDataProvider.dart';
import 'package:movie_tmdb/widgets/PaintCircle.dart';
import 'package:movie_tmdb/widgets/movieList/movieList.dart';
import 'package:movie_tmdb/widgets/movieList/movie_list_model.dart';
import 'package:movie_tmdb/widgets/screens/mainScreen/mainScreen_model.dart';
import 'package:movie_tmdb/widgets/screens/news/news_widget.dart';
import 'package:movie_tmdb/widgets/screens/tvShow/tvShowList.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final model = MovieListModel();
  int _selectedIndex = 1;

  void onChnageSelectedIndex(index) {
    if (index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    model.loadMovies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Show Snackbar',
              onPressed: () => Sessiondataprovider().setSession(null)),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'TMDB',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: onChnageSelectedIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Новини"),
            BottomNavigationBarItem(
                icon: Icon(Icons.movie_filter), label: "Фільми"),
            BottomNavigationBarItem(icon: Icon(Icons.tv), label: "Серіали"),
          ]),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          NewsWidget(),
          ModelProvider(model: model, child: Movielist()),
          TWShowListWidget(),
        ],
      ),
    );
  }
}
