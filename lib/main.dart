import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:movie_tmdb/Theme/appColors.dart';
import 'package:movie_tmdb/widgets/auth/auth_model.dart';
import 'package:movie_tmdb/widgets/screens/mainScreen/mainScreen.dart';
import 'package:movie_tmdb/widgets/details/MovieDetails.dart';
import 'package:movie_tmdb/widgets/auth/authLogin.dart';

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
          appBarTheme: const AppBarTheme(
            backgroundColor: Appcolors.dartBlue,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Appcolors.dartBlue,
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.lightBlue),
          iconTheme: const IconThemeData(color: Colors.white)),
      routes: {
        '/auth': (context) => AuthProvider(model: AuthModel(), child: const Authlogin()),
        "/main": (context) => const MainScreen(),
        "/main/details": (context) {
          final id = ModalRoute.of(context)?.settings.arguments;
          if (id is int) {
            return Moviedetails(movieId: id);
          } else {
            return Moviedetails(movieId: 1);
          }
        },
      },
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text(
                "Error",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            body: const Center(
              child: Text(
                "404 Page not found",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
          );
        });
      },
      initialRoute: "/auth",
    );
  }
}
