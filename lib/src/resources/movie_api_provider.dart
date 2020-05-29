import 'dart:async';
import 'package:flutterapparchitecture/src/models/trailer_model.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';

class MovieApiProvider{

  Client client = Client();
  String _apiKey = '798920b941701a984a18d3ac6d9a9b0c';
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  Future<TrailerModel> fetchTrailer(int movieId) async {
    String movieTrailerUrl = _baseUrl + "/" + movieId.toString() + "/videos?api_key=" + _apiKey ;
    final response = await client.get(movieTrailerUrl);

    if(response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load trailers');
    }
  }

  Future<ItemModel> fetchMovieList() async {
    print("entered");
    String url = "http://api.themoviedb.org/3/movie/popular?api_key=";
    String urlToHit = url + _apiKey;

    final response = await client.get(urlToHit);
    print(response.body.toString());
    if(response.statusCode == 200){
      return ItemModel.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load post');
    }

  }

}