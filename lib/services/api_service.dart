import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whenflix/models/api_response.dart';
import 'package:whenflix/models/models.dart';

class ApiService {

  Future<APIResponse<List<MovieModel>>> getMoviesListByGenre(String genre) {
    
    return http.get(Uri.parse("http://10.0.2.2:3000/movies")).then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);
        final movies = <MovieModel>[];
        for (var item in jsonData) {
          movies.add(MovieModel.fromJson(item));
        }
        return APIResponse<List<MovieModel>>(data: movies);
      }
      return APIResponse<List<MovieModel>>(error: true, errorMessage: "${data.statusCode}");
    });

  }

  Future<APIResponse<List<MovieModel>>> getMoviesByTitle(String title) {

    return http.get(Uri.parse("http://10.0.2.2:3000/movies?title=$title")).then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);
        final movies = <MovieModel>[];
        for (var item in jsonData) {
          movies.add(MovieModel.fromJson(item));
        }
        return APIResponse<List<MovieModel>>(data: movies);
      }
      return APIResponse<List<MovieModel>>(error: true, errorMessage: "${data.statusCode}");
    });

  }

}