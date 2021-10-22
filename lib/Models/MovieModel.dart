// To parse this JSON data, do
//
//     final Movies = MoviesFromJson(jsonString);

import 'dart:convert';

Movies MoviesFromJson(String str) => Movies.fromJson(json.decode(str));

String MoviesToJson(Movies data) => json.encode(data.toJson());

class Movies {
  Movies({
    required this.searchType,
    required this.expression,
    required this.results,
    required this.errorMessage,
  });

  String searchType;
  String expression;
  List<Result> results;
  String errorMessage;

  factory Movies.fromJson(Map<String, dynamic> json) => Movies(
        searchType: json["searchType"],
        expression: json["expression"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "searchType": searchType,
        "expression": expression,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "errorMessage": errorMessage,
      };
}

class Result {
  Result({
    required this.id,
    required this.resultType,
    required this.image,
    required this.title,
    required this.description,
  });

  String id;
  String resultType;
  String image;
  String title;
  String description;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        resultType: json["resultType"],
        image: json["image"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "resultType": resultType,
        "image": image,
        "title": title,
        "description": description,
      };
}
