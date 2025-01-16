import 'package:flutter/material.dart';
import 'package:movie_tmdb/Theme/app_images.dart';
import 'package:movie_tmdb/widgets/PaintCircle.dart';
import 'package:movie_tmdb/widgets/movieList/movieList.dart';
import 'package:movie_tmdb/widgets/screens/news/news_widget.dart';
import 'package:movie_tmdb/widgets/screens/tvShow/tvShowList.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;

  void onChnageSelectedIndex(index) {
    if (index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          // Text("Новини"),
          NewsWidget(),
          const Movielist(),
          TWShowListWidget(),
        ],
      ),
    );
  }
}
