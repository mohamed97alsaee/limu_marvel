import 'dart:async';
import 'dart:convert';

import '../models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class MoviesProvider with ChangeNotifier {
  List<MovieModel> movies = [];

  bool isFailed = false;
  bool isLoading = false;

  setFailed(bool status) {
    Timer(const Duration(milliseconds: 50), () {
      isFailed = status;
      notifyListeners();
    });
  }

  setLoading(bool status) {
    Timer(const Duration(milliseconds: 50), () {
      isLoading = status;
      notifyListeners();
    });
  }

  getMovies() async {
    setLoading(true);

    Response response =
        await http.get(Uri.parse("https://mcuapi.herokuapp.com/api/v1/movies"));
    debugPrint("STATUS CODE : ${response.statusCode}");
    debugPrint("BODY IS : ${response.body}");

    if (response.statusCode == 200) {
      setFailed(false);
      var decodedData = json.decode(response.body)['data'];

      for (var x in decodedData) {
        movies.add(MovieModel.fromJson(x));
      }
    } else {
      setFailed(true);
    }

    setLoading(false);
  }
}
