import 'package:flutter/material.dart';
import 'package:flutterapparchitecture/src/resources/movie_detail_bloc_provider.dart';
import 'package:flutterapparchitecture/src/ui/movie_detail.dart';
import '../models/item_model.dart';
import '../blocs/movies_bloc.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(
              snapshot.error.toString(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].poster_path}',
                fit: BoxFit.cover,
              ),
              onTap: () {
                openDetailPage(snapshot.data, index);
              },
            ),
          );
        });
  }

  void openDetailPage(ItemModel data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MovieDetailBlocProvider(
            child: MovieDetail(),
          );
        },
        settings: RouteSettings(
          arguments: data.results[index]
        )
      ),
    );
  }
}
