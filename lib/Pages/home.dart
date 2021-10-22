import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imdb_search/Models/MovieModel.dart';
import 'package:imdb_search/Network/api.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  String _movieName = "";
  List<String> movieRatings = <String>[];
  List<String> movieRatings2 = <String>[];

  static Color findColor(double num) {
    if (num < 4)
      return Color(0xFFf01111);
    else if (num > 3 && num < 6)
      return Color(0xFF0f4bff);
    else if (num > 6)
      return Color(0xFF30fc03);
    else
      return Color(0xFF0f4bff);
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Home",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              width: 325,
              height: 50,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFFFFFFF),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: Colors.black),
                    onPressed: () async {
                      showAlertDialog(context);
                      _movieName = searchController.text;
                      movieRatings.clear();
                      List<Result> tempResult =
                          await ApiEndpoints.getMovies(_movieName);
                      if (tempResult != null) {
                        for (int i = 0; i < tempResult.length; i++) {
                          String temp =
                              await ApiEndpoints.getRatings(tempResult[i].id);
                          movieRatings.add(temp);
                        }
                      }
                      Navigator.pop(context);
                      setState(() {
                        _movieName = searchController.text;
                        movieRatings2 = movieRatings;
                      });
                    },
                  ),
                  border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(0.0),
                      ),
                      borderSide: new BorderSide(
                        color: Color(0xFFB74093),
                        width: 5.0,
                      )),
                  hintText: 'Search for movies',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _movieName.isEmpty
              ? Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 250,
                      ),
                      Text(
                        "Search your favourite movies now",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                )
              : Flexible(
                  child: Center(
                    child: FutureBuilder<List<Result>>(
                      future: ApiEndpoints.getMovies(_movieName),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Result>? result = snapshot.data;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: result!.length,
                            itemBuilder: (BuildContext, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 10),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 500.0,
                                      height: 150.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      margin: EdgeInsets.only(top: 15.0),
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              result[index].title,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              result[index].description,
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Container(
                                              width: 80,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: findColor(double.parse(
                                                    movieRatings2[index])),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              alignment: Alignment.center,
                                              // child: FutureBuilder(
                                              //   future:
                                              //       ApiEndpoints.getMovies(
                                              //           result[index].id),
                                              //   builder: (context, snapshot) {
                                              //     if (snapshot.hasData) {
                                              //       String ratingString =
                                              //           snapshot.toString();
                                              //       return Text(
                                              //         ratingString,
                                              //         style: TextStyle(
                                              //           color: Colors.white,
                                              //           fontWeight:
                                              //               FontWeight.w200,
                                              //         ),
                                              //       );
                                              //     } else if (snapshot
                                              //         .hasError) {
                                              //       return Text(
                                              //           "${snapshot.error}");
                                              //     } else {
                                              //       return Text(
                                              //         "IMDB RATING",
                                              //         style: TextStyle(
                                              //           color: Colors.white,
                                              //           fontWeight:
                                              //               FontWeight.w200,
                                              //         ),
                                              //       );
                                              //     }
                                              //   },
                                              child: Text(
                                                movieRatings2[index] + " IMDB",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        result[index].image,
                                        height: 150.0,
                                        width: 100.0,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
