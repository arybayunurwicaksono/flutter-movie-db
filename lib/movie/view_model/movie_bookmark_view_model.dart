import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:yt_flutter_movie_db/app_constants.dart';
import 'package:yt_flutter_movie_db/movie/models/bookmark_movie_model.dart';
import 'package:yt_flutter_movie_db/movie/models/bookmark_remove_type.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_detail_model.dart';
import 'package:yt_flutter_movie_db/movie/repository/movie_repository.dart';

part 'movie_bookmark_view_model.g.dart';

class MovieBookmarkViewModel = _movieBookmarkViewModel
    with _$MovieBookmarkViewModel;

abstract class _movieBookmarkViewModel with Store {
  final MovieRepository _movieRepository;

  _movieBookmarkViewModel(this._movieRepository);

  @observable
  Box<BookmarkMovieModel>? movieDb;

  @observable
  bool status = false;

  @observable
  String? searchQuery = "";

  @observable
  Future<Box<BookmarkMovieModel>> getBookmarkWithDb() async {
    movieDb = await _movieRepository.getIdArrayWithDb();
    return movieDb!;
  }

  @action
  Future<void> removeBookmarkWithDb(String id, BookmarkRemoveType type) async {
    switch (type) {
      case BookmarkRemoveType.list:
        await _movieRepository.saveIdArrayWithDb(int.parse(id));
        final _dbBox = await _movieRepository.getIdArrayWithDb();
        runInAction(() {
          movieDb = _dbBox;
        });
        break;
      case BookmarkRemoveType.detail:
        final _dbBox = await _movieRepository.getIdArrayWithDb();
        if (_dbBox != null) {
          for (int i = 0; i < _dbBox!.length; i++) {
            if (movieDb!.getAt(i)!.id == int.parse(id)) {
              await _movieRepository.saveIdArrayWithDb(i);
              changeBookmarkStatus();
              runInAction(() {
                movieDb = _dbBox;
              });
            }
          }
        } else {
          print('BookmarkTesting (viewModel): movieDb is empty');
        }
        break;
    }
  }

  @action
  Future<bool> isBookmarked(int id) async {
    movieDb = await getBookmarkWithDb();
    if (movieDb != null) {
      for (int i = 0; i < movieDb!.length; i++) {
        print(
            'BookmarkTesting (viewModel): $i, ${movieDb!.getAt(i).toString()}');
        if (movieDb!.getAt(i)!.id == id) {
          changeBookmarkStatus();
          return status;
        }
      }
    } else {
      print('BookmarkTesting (viewModel): movieDb is empty');
    }
    return status;
  }

  @action
  Future<void> addBookmarkWithDb(MovieDetailModel movie) async {
    var movies = BookmarkMovieModel(
      backdropPath: movie.backdropPath,
      id: movie.id,
      posterPath: movie.posterPath,
      title: movie.title,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
    );

    _movieRepository.addIdWithDb(movie: movies);
    changeBookmarkStatus();
  }

  @action
  void changeBookmarkStatus() {
    status = !status;
  }

  @action
  Future<void> saveEncryptedData(String key, String value) async {
    await _movieRepository.saveEncryptedData(key, value);
    getEncryptedData(key);
  }

  @action
  Future<void> getEncryptedData(String key) async {
    searchQuery = await _movieRepository.getEncryptedData('searchQuery');
  }

  @action
  Future<void> deleteEncryptedData(String key) async {
    await _movieRepository.deleteEncryptedData(key);
  }
}
