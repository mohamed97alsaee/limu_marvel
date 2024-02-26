import 'package:limu_marvel/helpers/consts.dart';

import '../models/movie_model.dart';
import 'package:flutter/material.dart';

class DetailedMovieScreen extends StatefulWidget {
  const DetailedMovieScreen({super.key, required this.movieModel});
  final MovieModel movieModel;
  @override
  State<DetailedMovieScreen> createState() => _DetailedMovieScreenState();
}

class _DetailedMovieScreenState extends State<DetailedMovieScreen> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(widget.movieModel.title,
              style: const TextStyle(color: Colors.black))),
      body: Column(children: [
        Divider(
          height: 0,
          color: primaryColor.withOpacity(0.2),
        ),
        Padding(
          padding: const EdgeInsets.all(26.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.network(
              widget.movieModel.coverUrl,
            ),
          ),
        )
      ]),
    );
  }
}
