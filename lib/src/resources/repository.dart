import 'dart:async';
import 'package:flutterapparchitecture/src/models/trailer_model.dart';
import 'movie_api_provider.dart';
import '../models/item_model.dart';

class Repository{

  final movieApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies () {
    return movieApiProvider.fetchMovieList();
  }

  Future<TrailerModel> fetchTrailers(int movieId) {
    return movieApiProvider.fetchTrailer(movieId);
  }

}