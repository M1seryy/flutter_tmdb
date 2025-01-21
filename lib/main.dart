import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:movie_tmdb/Theme/appColors.dart';
import 'package:movie_tmdb/main_model.dart';
import 'package:movie_tmdb/widgets/auth/auth_model.dart';
import 'package:movie_tmdb/widgets/navigation/mainNavigation.dart';
import 'package:movie_tmdb/widgets/screens/mainScreen/mainScreen.dart';
import 'package:movie_tmdb/widgets/details/MovieDetails.dart';
import 'package:movie_tmdb/widgets/auth/authLogin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = MainModel();
  await model.checkAuth();
  runApp(MyApp(
    model: model,
  ));
}

class MyApp extends StatelessWidget {
  static final mainNav = MainNavigation();
  final MainModel model;
  const MyApp({required this.model});

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
      routes: mainNav.routes,
      onGenerateRoute: mainNav.onGenerateRoute,
      initialRoute: mainNav.initialRoute(model.isAuth),
    );
  }
}
