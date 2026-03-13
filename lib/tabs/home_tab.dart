import 'package:flutter/material.dart';

import '../api/api_manager.dart';
import '../models/movie.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Movies> movies = [];

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  loadmovies() async {
    Movie response = (await ApiManager.getMovies()) as Movie;

    movies = response.data?.movies ?? [];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                movies[0].largeCoverImage ?? "",
                height: 420,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Container(
                height: 420,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.transparent],
                )),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  Text(
                    "available now ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  Text(
                    "watch now ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Action ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "See More →",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GridView.builder(
            itemCount: movies.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.65),
            itemBuilder: (context, index) {
              var movie = movies[index];
              return Stack(
                children: [
                  ClipRect(
                    // borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      "movie.mediumCoverImage" ?? "",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text(
                              movie.rating.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Icon(Icons.star, color: Colors.amber,size: 14),
                          ],
                        ),
                      ))
                ],
              );
            },
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
