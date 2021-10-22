import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:imdb_search/Models/MovieModel.dart';
import 'package:imdb_search/Models/RatingModel.dart';

class ApiEndpoints {
  static String root = "http://imdb-api.com/en/API/";
  static String ApiKey = "k_0hves42w";
  static String ApiKey2 = "k_23sxmgl4";

  static Future<List<Result>> getMovies(String name) async {
    String movie = root + "SearchMovie/" + ApiKey2 + "/" + name;
    print(movie);
    var response = await http.get(Uri.parse(movie));
    print(response.statusCode);
    print(response.body);

    var jsonData = json.decode(response.body);
    final movieItem =
        List<Result>.from(jsonData['results'].map((x) => Result.fromJson(x)));

    return movieItem;
  }

  static Future<String> getRatings(String Movieid) async {
    String rating = root + "Ratings/" + ApiKey2 + "/" + Movieid;
    print(rating);
    var response = await http.get(Uri.parse(rating));
    print(response.statusCode);
    print(response.body);
    var jsonData = json.decode(response.body);
    final ratingItem = jsonData['imDb'];
    // List<Rating>.from(jsonData['imDb'].map((x) => Result.fromJson(x)));

    return ratingItem;
  }
}
