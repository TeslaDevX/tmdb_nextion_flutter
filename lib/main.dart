import 'package:flutter/material.dart';
import 'widgets/toprated.dart';
import 'widgets/trending.dart';
import 'widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String apikey = '3b2654b0b794517e22a5d6c643b7e8e4';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzYjI2NTRiMGI3OTQ1MTdlMjJhNWQ2YzY0M2I3ZThlNCIsInN1YiI6IjY1YTNjNTk1ZDM1ZGVhMDEyODQzMTEwMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xYS7ufkMwXeqS5Bb6-E2UiQI26jpQNolNEcHLCCMqm8';

  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovies();
  }

  getMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingMovie = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topRatedMovie = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvShows = await tmdbWithCustomLogs.v3.tv.getPopular();

    setState(() {
      trendingmovies = trendingMovie['results'];
      topratedmovies = topRatedMovie['results'];
      tv = tvShows['results'];
    });
    print(trendingmovies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Movie App IMDB'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          TrendingMovies(trending: trendingmovies),
          TopRatedMovies(toprated: topratedmovies),
          TV(tv: tv),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
