import 'package:flutter/material.dart';
import 'package:movie_tmdb/domain/dataProvider/ProviderInherited.dart';
import 'package:movie_tmdb/widgets/Trailer/MovieTrailer.dart';
import 'package:movie_tmdb/widgets/auth/authLogin.dart';
import 'package:movie_tmdb/widgets/auth/auth_model.dart';
import 'package:movie_tmdb/widgets/details/MovieDetails.dart';
import 'package:movie_tmdb/widgets/details/MovieDetailsModel.dart';
import 'package:movie_tmdb/widgets/movieList/movieList.dart';
import 'package:movie_tmdb/widgets/movieList/movie_list_model.dart';
import 'package:movie_tmdb/widgets/screens/mainScreen/mainScreen.dart';
import 'package:movie_tmdb/widgets/screens/mainScreen/mainScreen_model.dart';

abstract class MainNavRoutes {
  static const auth = "auth";
  static const mainScreen = "/";
  static const movieDetails = "/details";
  static const movieTrailer = "/details/trailer";
}

class MainNavigation {
  String initialRoute(bool isAuth) =>
      isAuth ? MainNavRoutes.mainScreen : MainNavRoutes.auth;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavRoutes.auth: (context) => ModelProviderStateFull(
        create: () => AuthModel(), child: const Authlogin()),
    MainNavRoutes.mainScreen: (context) => ModelProviderStateFull(
        create: () => MovieListModel(), child: const MainScreen()),
  };
  Route<Object> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case MainNavRoutes.movieDetails:
        final arguments = setting.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
            builder: (context) => ModelProviderStateFull(
                create: () => MovieDetailsModel(movieId: movieId),
                child: const Moviedetails()));
      case MainNavRoutes.movieTrailer:
        final arguments = setting.arguments;
        final trailerKey = arguments is String ? arguments : "";
        return MaterialPageRoute(
            builder: (context) => MovieTrailer(trailerKey: trailerKey));
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
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
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ),
                ));
    }
  }
}
