// To parse this JSON data, do
//
//     final Rating = RatingFromJson(jsonString);

import 'dart:convert';

Rating RatingFromJson(String str) => Rating.fromJson(json.decode(str));

String RatingToJson(Rating data) => json.encode(data.toJson());

class Rating {
  Rating({
    // required this.imDbId,
    // required this.title,
    // required this.fullTitle,
    // required this.type,
    // required this.year,
    required this.imDb,
    // required this.metacritic,
    // required this.theMovieDb,
    // required this.rottenTomatoes,
    // required this.tVCom,
    // required this.filmAffinity,
    // required this.errorMessage,
  });

  // String imDbId;
  // String title;
  // String fullTitle;
  // String type;
  // String year;
  String imDb;
  // String metacritic;
  // String theMovieDb;
  // String rottenTomatoes;
  // String tVCom;
  // String filmAffinity;
  // String errorMessage;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        // imDbId: json["imDbId"],
        // title: json["title"],
        // fullTitle: json["fullTitle"],
        // type: json["type"],
        // year: json["year"],
        imDb: json["imDb"],
        // metacritic: json["metacritic"],
        // theMovieDb: json["theMovieDb"],
        // rottenTomatoes: json["rottenTomatoes"],
        // tVCom: json["tV_com"],
        // filmAffinity: json["filmAffinity"],
        // errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        // "imDbId": imDbId,
        // "title": title,
        // "fullTitle": fullTitle,
        // "type": type,
        // "year": year,
        "imDb": imDb,
        // "metacritic": metacritic,
        // "theMovieDb": theMovieDb,
        // "rottenTomatoes": rottenTomatoes,
        // "tV_com": tVCom,
        // "filmAffinity": filmAffinity,
        // "errorMessage": errorMessage,
      };
}
