import 'package:flutter/material.dart';
import 'package:yt_flutter_movie_db/movie/repository/movie_repository.dart';

class MovieBookmarkProvider extends ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieBookmarkProvider(this._movieRepository);

  List<String>? _movie;
  List<String>? get movie => _movie;

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

  bool isBookmarked(int id) {
    getBookmark();
    return _movie!.contains('$id');
  }
}
