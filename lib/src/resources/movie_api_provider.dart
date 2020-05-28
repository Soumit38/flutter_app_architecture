import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';

class MovieApiProvider{

  Client client = Client();
  String _apiKey = '798920b941701a984a18d3ac6d9a9b0c';

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