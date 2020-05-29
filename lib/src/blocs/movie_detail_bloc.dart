import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/trailer_model.dart';
import '../resources/repository.dart';

class MovieDetailBloc {
  /*
  The main difference between PublishSubject and BehaviorSubject is that
  the latter one remembers the last emitted item. Because of that BehaviorSubject
  is really useful when you want to emit states
   */
  final _repository = new Repository();
  final _movieId = PublishSubject<int>();
  final _trailers = BehaviorSubject<Future<TrailerModel>>();

  Function(int) get fetchTrailerById => _movieId.sink.add;

  Stream<Future<TrailerModel>> get movieTrailers => _trailers.stream;

  /*
  inside-pipe => consumer
  inside-transform => transformer
   */

  MovieDetailBloc() {
    _movieId.stream.transform(_itemTransformer()).pipe(_trailers);
  }

  _itemTransformer() {
    return ScanStreamTransformer(
      (Future<TrailerModel> trailer, int id, int index) {
        print(index);
        trailer = _repository.fetchTrailers(id);
        return trailer;
      },
    );
  }

  dispose() async {
    _movieId.close();
    await _trailers.drain();
    _trailers.close();
  }
}

//final movieDetailsBloc = new MovieDetailBloc();
