import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:yt_flutter_movie_db/movie/models/bookmark_movie_model.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_detail_model.dart';
import 'package:yt_flutter_movie_db/movie/repository/movie_repository.dart';

class MovieBookmarkProvider extends ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieBookmarkProvider(this._movieRepository);

  List<String>? _movie;
  List<String>? get movie => _movie;

  Box<BookmarkMovieModel>? _movieDb;
  Box<BookmarkMovieModel>? get movieDb => _movieDb;

  bool bookmarkStatus = false;

  void addBookmark(String id) {
    _movieRepository.addId(id: id);
    notifyListeners();
  }

  void getBookmark() async {
    _movie = await _movieRepository.getIdArray();
    notifyListeners();
  }

  void removeBookmark(String id) async {
    final result = await _movieRepository.getIdArray();
    if (result != null) {
      result.remove(id);
      await _movieRepository.saveIdArray(result);
      _movie = result;
      notifyListeners();
    }
  }

  void addBookmarkWithDb(MovieDetailModel movie) {
    var movies = BookmarkMovieModel(
      backdropPath: movie.backdropPath,
      id: movie.id,
      posterPath: movie.posterPath,
      title: movie.title,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
    );
    _movieRepository.addIdWithDb(movie: movies);
    notifyListeners();
  }

  Future<Box<BookmarkMovieModel>> getBookmarkWithDb() async {
    _movieDb = await _movieRepository.getIdArrayWithDb();
    notifyListeners();
    return _movieDb!;
  }

  void removeBookmarkWithDb(String id) async {
    await _movieRepository.saveIdArrayWithDb(int.parse(id));
    notifyListeners();
  }

  bool isBookmarked(int id) {
    bool status = false;
    for (int i = 0; i < _movieDb!.length; i++) {
      print('BookmarkTesting : $i, ${_movieDb!.getAt(i).toString()}');
      if (_movieDb!.getAt(i)!.id == id) {
        notifyListeners();
        return status = true;
      }
    }
    return status;
  }
}
