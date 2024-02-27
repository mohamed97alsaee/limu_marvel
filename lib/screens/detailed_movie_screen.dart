import 'package:limu_marvel/helpers/consts.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: SingleChildScrollView(
        child: Column(children: [
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 0),
            child: Column(
              children: [
                Text(
                  widget.movieModel.title.toString(),
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(Icons.video_camera_back_rounded,
                        color: Color(0xff818181)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.movieModel.directedBy,
                      style: const TextStyle(
                          fontSize: 14, color: Color(0xff818181)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(Icons.schedule, color: Color(0xff818181)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      Duration(minutes: widget.movieModel.duration)
                          .toString()
                          .substring(0, 4),
                      style: const TextStyle(
                          fontSize: 14, color: Color(0xff818181)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (widget.movieModel.overview != null)
                  Text(
                    widget.movieModel.overview.toString(),
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                if (widget.movieModel.trailerUrl != null)
                  ElevatedButton(
                      onPressed: () async {
                        Uri url =
                            Uri.parse(widget.movieModel.trailerUrl.toString());

                        bool launchable = await canLaunchUrl(url);
                        if (launchable) {
                          launchUrl(url);
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Watch Trailer"),
                          Icon(Icons.play_arrow_rounded)
                        ],
                      ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
