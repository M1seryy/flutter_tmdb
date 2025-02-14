import 'package:flutter/material.dart';
import 'package:movie_tmdb/domain/api_client/api.dart';
import 'package:movie_tmdb/domain/dataProvider/ProviderInherited.dart';
import 'package:movie_tmdb/domain/entity/movie_details_credits.dart';
import 'package:movie_tmdb/widgets/PaintCircle.dart';
import 'package:movie_tmdb/widgets/details/MovieDetailsModel.dart';

class MainMovieInfo extends StatelessWidget {
  const MainMovieInfo({super.key});

  @override
  Widget build(BuildContext context) {
    const baseImagePath = 'https://image.tmdb.org/t/p/original';
    const backDropPath = '/abwxHfymXGAbbH3lo9PDEJEfvtW.jpg';
    const posterImage = '/oZNPzxqM2s5DyVWab09NTQScDQt.jpg';
    return const Column(
      children: [
        _PosterWidget(
            baseImagePath: baseImagePath,
            backDropPath: backDropPath,
            posterImage: posterImage),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: TextWidget(),
        ),
        RatingWidget(),
        SummaryText(),
        SizedBox(
          height: 10,
        ),
        OverviewWidget(),
        SizedBox(
          height: 20,
        ),
        PeopleInfoWidget(),
      ],
    );
  }
}

class _PosterWidget extends StatelessWidget {
  const _PosterWidget({
    required this.baseImagePath,
    required this.backDropPath,
    required this.posterImage,
  });

  final String baseImagePath;
  final String backDropPath;
  final String posterImage;

  @override
  Widget build(BuildContext context) {
    final model = ModelProviderStateFull.watch<MovieDetailsModel>(context);
    final poster = model?.movieDetails?.posterPath;
    final backDrop = model?.movieDetails?.backdropPath;

    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: backDrop != null
                ? Image.network(api_client.posterUrl(backDrop))
                : const SizedBox.shrink(),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30, left: 10),
            width: 100,
            child: poster != null
                ? Image.network(api_client.posterUrl(poster))
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = ModelProviderStateFull.watch<MovieDetailsModel>(context);
    final title = model?.movieDetails?.title;
    var yearOfRelize;
    if (model?.movieDetails?.releaseDate?.year != null) {
      yearOfRelize = '  ${model?.movieDetails?.releaseDate?.year}';
    }

    return RichText(
      textAlign: TextAlign.center,
      maxLines: 3,
      text: TextSpan(children: [
        TextSpan(
            text: title ?? "123",
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 21)),
        TextSpan(
            text: yearOfRelize.toString() ?? "---",
            style: const TextStyle(
                fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey))
      ]),
    );
  }
}

class SummaryText extends StatelessWidget {
  const SummaryText({super.key});

  @override
  Widget build(BuildContext context) {
    final model = ModelProviderStateFull.watch<MovieDetailsModel>(context);
    if (model == null) return const SizedBox.shrink();
    var texts = <String>[];
    final relizeDate = model.movieDetails?.releaseDate;
    if (relizeDate != null) {
      texts.add(model.stringFromDate(relizeDate));
    }
    final country = model.movieDetails?.productionCountries;
    if (country != null && country.isNotEmpty) {
      texts.add('(${country.first.iso})');
    }
    final runtime = model.movieDetails?.runtime;
    final duratioon = Duration(minutes: runtime!);
    final hours = duratioon.inHours;
    final minutes = duratioon.inMinutes.remainder(60);
    texts.add('(${hours}h $minutes m)');

    final genres = model.movieDetails?.genres;
    if (genres != null && genres.isNotEmpty) {
      var genresNames = <String>[];
      for (var genre in genres) {
        genresNames.add(genre.name);
      }
      texts.add(genresNames.join(", "));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ColoredBox(
        color: const Color.fromRGBO(22, 21, 25, 1.0),
        child: Text(
          textAlign: TextAlign.center,
          texts.join(" "),
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class PeopleInfoWidget extends StatelessWidget {

  const PeopleInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = ModelProviderStateFull.watch<MovieDetailsModel>(context);
    var crew = model?.movieDetails?.credits.crew;
if (crew == null || crew.isEmpty) return const SizedBox.shrink();  
  crew = crew.length >4 ?crew.sublist(0,4) :crew; 
var crewChunks = <List<Employee>>[];
for (var i = 0; i < crew.length; i+=2) {
    crewChunks.add(crew.sublist(i,i+2 > crew.length ? crew.length :i+2));
}


   
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 30),
      child:  Column(
        children: 
          crewChunks.map((chunk) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: PeopleWidgetRow(employes: chunk),
          )).toList(),
          // PeopleWidgetRow(),
          // SizedBox(
          //   height: 20,
          // ),
          //  PeopleWidgetRow(),
        
      ),
    );
  }
}

class PeopleWidgetRow extends StatelessWidget {
  final List<Employee> employes;
  
  const PeopleWidgetRow({
    super.key, required this.employes,
  });
 

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: 
      employes.map((employee) => PeopleWidgetItem(employee: employee)).toList(),
     
    );
  }


}

class PeopleWidgetItem extends StatelessWidget {
  final Employee employee;
  const PeopleWidgetItem({
    super.key, required this.employee,
   
  });



  @override
  Widget build(BuildContext context) {
     const _jobStyle =
        TextStyle(fontWeight: FontWeight.w500, color: Colors.white);

     const _actorStyle =
        TextStyle(fontWeight: FontWeight.w800, color: Colors.white);
    return  Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(employee.name, style: _actorStyle),
          Text(
            employee.job,
            style: _jobStyle,
          ),
        ],
      ),
    );
  }
}

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = ModelProviderStateFull.watch<MovieDetailsModel>(context);
    final overview = model?.movieDetails?.overview;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            overview.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = ModelProviderStateFull.watch<MovieDetailsModel>(context);
    var userScore = model?.movieDetails?.voteAverage ?? 0;
    userScore = userScore / 10;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: null,
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                child: Paintcircle(
                  percentage: userScore,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "User score",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        Container(
          width: 1,
          height: 20,
          color: Colors.grey,
        ),
        const Row(
          children: [
            Icon(Icons.play_arrow),
            SizedBox(
              width: 20,
            ),
            Text(
              "Play trailer",
              style: TextStyle(color: Colors.white),
            ),
          ],
        )
      ],
    );
  }
}
