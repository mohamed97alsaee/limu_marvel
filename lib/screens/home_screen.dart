import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:limu_marvel/helpers/consts.dart';
import 'package:limu_marvel/models/movie_model.dart';
import 'package:limu_marvel/widgets/movie_card.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:limu_marvel/widgets/shimmer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MovieModel> movies = [];

  bool isFailed = false;
  bool isLoading = false;

  getMovies() async {
    setState(() {
      isLoading = true;
    });
    Response response =
        await http.get(Uri.parse("https://mcuapi.herokuapp.com/api/v1/movies"));
    debugPrint("STATUS CODE : ${response.statusCode}");
    debugPrint("BODY IS : ${response.body}");

    if (response.statusCode == 200) {
      isFailed = false;
      var decodedData = json.decode(response.body)['data'];

      for (var x in decodedData) {
        movies.add(MovieModel.fromJson(x));
      }
      setState(() {});
    } else {
      setState(() {
        isFailed = true;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getMovies();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/InvertedLogo.png",
          width: size.width * 0.2,
        ),
      ),
      body: isFailed
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.network_locked_sharp,
                      color: primaryColor.withOpacity(0.6),
                      size: size.width * 0.2),
                  const Text(
                    "Somthing went wrong!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black54),
                  )
                ],
              ),
            )
          : Column(
              children: [
                Divider(
                  color: primaryColor.withOpacity(0.2),
                  height: 0,
                ),
                Expanded(
                  child: GridView.builder(
                      padding: const EdgeInsets.all(24),
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 24),
                      itemCount: isLoading ? 10 : movies.length,
                      itemBuilder: (context, index) {
                        return isLoading
                            ? const ShimmerWidget()
                            : MovieCard(
                                movieModel: movies[index],
                              );
                      }),
                )
              ],
            ),
    );
  }
}
