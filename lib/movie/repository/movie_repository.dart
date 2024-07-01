import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:yt_flutter_movie_db/movie/models/bookmark_movie_model.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_detail_model.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_model.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_video_model.dart';

abstract class MovieRepository {
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1});
  Future<Either<String, MovieResponseModel>> getTopRated({int page = 1});
  Future<Either<String, MovieResponseModel>> getNowPlaying({int page = 1});
  Future<Either<String, MovieResponseModel>> search({required String query});
  Future<Either<String, MovieDetailModel>> getDetail({required int id});
  Future<Either<String, MovieVideosModel>> getVideos({required int id});
  Future<void> addId({required String id});
  Future<List<String>?> getIdArray();
  Future<void> saveIdArray(List<String> idArray);
  Future<void> addIdWithDb({required BookmarkMovieModel movie});
  Future<Box<BookmarkMovieModel>> getIdArrayWithDb();
  Future<void> saveIdArrayWithDb(int idArray);
  Future<bool> checkBookmarkWithDb(int idArray);
  Future<void> saveEncryptedData(String key, String value);
  Future<String?> getEncryptedData(String key);
  Future<void> deleteEncryptedData(String key);
  Future<Either<String, MovieResponseModel>> getLastSearch(
      {required String query, int page = 1});
}
