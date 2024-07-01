import 'package:hive/hive.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_model.dart';

class HiveDb {
  final _bookmark = Hive.box('bookmark');

  void addBookmark(String id, MovieModel movie) {
    _bookmark.put(id, movie);
  }

  MovieModel getBookmark(String id) {
    return _bookmark.get(id);
  }

  void removeBookmark(String id) {
    _bookmark.delete(id);
  }

  //
}
