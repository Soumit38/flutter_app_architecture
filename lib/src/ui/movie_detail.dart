import 'package:flutter/material.dart';
import 'package:flutterapparchitecture/src/blocs/movie_detail_bloc.dart';
import 'package:flutterapparchitecture/src/models/result.dart';
import 'package:flutterapparchitecture/src/models/trailer_model.dart';
import '../resources/movie_detail_bloc_provider.dart';

class MovieDetail extends StatefulWidget {

  @override
  _MovieDetailState createState() {
    return _MovieDetailState();
  }
}

class _MovieDetailState extends State<MovieDetail> {

  MovieDetailBloc bloc;
  Result result;


  @override
  void initState() {

  }


  @override
  void didChangeDependencies() {
    result = ModalRoute.of(context).settings.arguments;
    bloc = MovieDetailBlocProvider.of(context);
    bloc.fetchTrailerById(result.id);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            String urlDetalis = "https://image.tmdb.org/t/p/w500" + result.poster_path;
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      urlDetalis,
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(margin: EdgeInsets.only(top: 5.0)),
                Text(
                  result.title,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 1.0, right: 1.0),
                    ),
                    Text(
                      "5.55",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                    Text(
                      result.release_date,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Text(result.overview, style: TextStyle(fontSize: 18),),
                StreamBuilder(
                  stream: bloc.movieTrailers,
                  builder: (context, AsyncSnapshot<Future<TrailerModel>> snapshot){
                    if(snapshot.hasData){
                      return FutureBuilder(
                        future: snapshot.data,
                        builder: (context, AsyncSnapshot<TrailerModel> itemSnapShot){
                          if(itemSnapShot.hasData){
                            if(itemSnapShot.data.results.length > 0)
                              return trailerLayout(itemSnapShot.data);
                            else
                              return noTrailer(itemSnapShot.data);
                          }else{
                            return Center(child: CircularProgressIndicator(),);
                          }
                        },
                      );
                    }else{
                      return Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget trailerLayout(TrailerModel data) {
    if (data.results.length > 1) {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
          trailerItem(data, 1),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
        ],
      );
    }
  }

  Widget noTrailer(TrailerModel data) {
    return Center(
      child: Container(
        child: Text("No trailer available"),
      ),
    );
  }

  trailerItem(TrailerModel data, int index) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            height: 100.0,
            color: Colors.grey,
            child: Center(child: Icon(Icons.play_circle_filled)),
          ),
          Text(
            data.results[index].name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }


}












