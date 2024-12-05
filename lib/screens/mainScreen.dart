import 'package:flutter/material.dart';
import 'package:movie_tmdb/widgets/movieList.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  static const List<Widget> selectedOptions = [
    Text("Новини"),
    Movielist(),
    Text("Серіали"),
  ];
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
      body: Container(
        child: selectedOptions[_selectedIndex],
      ),
    );
  }
}
