import 'package:flutter/material.dart';
import 'package:movie_tmdb/screens/mainScreen.dart';
import 'package:movie_tmdb/widgets/authLogin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme:
            const AppBarTheme(backgroundColor: Color.fromRGBO(3, 37, 65, 1)),
      ),
      routes: {'/': (context) => Authlogin(), "/main": (context) => MainScreen()},
      initialRoute: "/",
    );
  }
}
