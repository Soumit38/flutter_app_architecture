import 'package:flutter/material.dart';
import 'package:flutterapparchitecture/src/blocs/movie_detail_bloc.dart';

class MovieDetailBlocProvider extends InheritedWidget {

  final MovieDetailBloc movieDetailBloc;

  MovieDetailBlocProvider({
    Key key,
    @required Widget child,
  })  : movieDetailBloc = MovieDetailBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(MovieDetailBlocProvider old) {
    return true;
  }

  static MovieDetailBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(MovieDetailBlocProvider)
            as MovieDetailBlocProvider)
        .movieDetailBloc;
  }
}
