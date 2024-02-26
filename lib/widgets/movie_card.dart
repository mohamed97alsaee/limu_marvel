import 'package:flutter/cupertino.dart';
import 'package:limu_marvel/screens/detailed_movie_screen.dart';

import '../models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:limu_marvel/helpers/consts.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movieModel});
  final MovieModel movieModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => DetailedMovieScreen(
                      movieModel: movieModel,
                    )));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
            footer: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.transparent,
                    Colors.black54,
                    Colors.black
                  ])),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      Duration(minutes: movieModel.duration)
                          .toString()
                          .substring(0, 4),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      movieModel.title,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      maxLines: 1,
                    )
                  ],
                ),
              ),
            ),
            child: Image.network(
              movieModel.coverUrl,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                    child: CircularProgressIndicator(
                  value: 0.5,
                  color: primaryColor,
                ));
              },
            )),
      ),
    );
  }
}
