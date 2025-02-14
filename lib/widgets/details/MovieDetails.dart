import 'package:flutter/material.dart';
import 'package:movie_tmdb/domain/dataProvider/ProviderInherited.dart';
import 'package:movie_tmdb/widgets/details/MovieDetailsModel.dart';
import 'package:movie_tmdb/widgets/details/mainMovieInfo.dart';
import 'package:movie_tmdb/widgets/details/screenCast.dart';

class Moviedetails extends StatefulWidget {
  const Moviedetails({
    super.key,
  });

  @override
  State<Moviedetails> createState() => _MoviedetailsState();
}

class _MoviedetailsState extends State<Moviedetails> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ModelProviderStateFull.read<MovieDetailsModel>(context)?.setupLocale();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextTitleWidget(),
      ),
      body: const ColoredBox(
        color: Color.fromRGBO(24, 23, 27, 1.0),
        child: _DetailsBody(),
      ),
    );
  }
}

class TextTitleWidget extends StatelessWidget {
  const TextTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = ModelProviderStateFull.watch<MovieDetailsModel>(context);
    return Text(
      model?.movieDetails?.title ?? "Loading...",
      style: const TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
    );
  }
}

class _DetailsBody extends StatelessWidget {
  const _DetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = ModelProviderStateFull.watch<MovieDetailsModel>(context);
    final movieDetails = model?.movieDetails;
    if (movieDetails == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: const [
        MainMovieInfo(),
        SizedBox(
          height: 30,
        ),
        Screencast()
      ],
    );
  }
}
