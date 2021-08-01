import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get_it/get_it.dart';
import 'package:whenflix/models/api_response.dart';
import 'package:whenflix/models/models.dart';
import 'package:whenflix/services/api_service.dart';
import 'package:whenflix/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiService get service => GetIt.I<ApiService>();
  APIResponse<List<MovieModel>>? _apiResponse;

  //categories lists
  List<MovieModel> _popularMovies = [];
  List<MovieModel> _dramaMovies = [];
  List<MovieModel> _thrillerMovies = [];

  bool _isLoading = false;

  _fetchMovies() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getMoviesListByGenre("");
    _apiResponse!.data!.forEach((element) {
      if (element.popular == true) {
        _popularMovies.add(element);
      }
      if (element.genres.contains("Drama")) {
        _dramaMovies.add(element);
      }
      if (element.genres.contains("Thriller")) {
        _thrillerMovies.add(element);
      }
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (_) {
            if (_isLoading) {
              return Center(child: CircularProgressIndicator(),);
            }
            if (_apiResponse!.error!) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 32),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        IconlyLight.star,
                        size: 30,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "HOT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                ContentHeader(
                  movie: _popularMovies[1],
                ),
                SizedBox(
                  height: 12,
                ),
                CategoryBox(
                  categoryName: "Popular",
                  categoryMovies: _popularMovies,
                ),
                CategoryBox(
                  categoryName: "Drama",
                  categoryMovies: _dramaMovies,
                ),
                CategoryBox(
                  categoryName: "Thriller",
                  categoryMovies: _thrillerMovies,
                ),
                CategoryBox(
                  categoryName: "All Movies",
                  categoryMovies: _apiResponse!.data!,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
