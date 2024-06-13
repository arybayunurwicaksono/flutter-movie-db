import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yt_flutter_movie_db/movie/models/bookmark_movie_model.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_detail_model.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_model.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_video_model.dart';
import 'package:yt_flutter_movie_db/movie/repository/movie_repository.dart';

import 'dart:developer' as developer;

class MovieRepositoryImpl implements MovieRepository {
  final Dio _dio;

  static const String _bookmarkBox = 'bookmark';

  MovieRepositoryImpl(this._dio);

  @override
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1}) async {
    try {
      final result =
          await _dio.get('/discover/movie', queryParameters: {'page': page});
      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }
      return const Left('Error get discover movies');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('another error on get discover movies');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> getTopRated({int page = 1}) async {
    try {
      final result =
          await _dio.get('/movie/top_rated', queryParameters: {'page': page});
      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }
      return const Left('Error get popular movies');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('another error on get popular movies');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> getNowPlaying(
      {int page = 1}) async {
    try {
      final result =
          await _dio.get('/movie/now_playing', queryParameters: {'page': page});
      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }
      return const Left('Error get now playing movies');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('another error on get now playing movies');
    }
  }

  @override
  Future<Either<String, MovieDetailModel>> getDetail({required int id}) async {
    try {
      final result = await _dio.get(
        '/movie/$id',
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieDetailModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get movie detail');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get movie detail');
    }
  }

  @override
  Future<Either<String, MovieVideosModel>> getVideos({required int id}) async {
    try {
      final result = await _dio.get(
        '/movie/$id/videos',
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieVideosModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get movie videos');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get movie videos');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> search(
      {required String query}) async {
    try {
      final result = await _dio.get(
        '/search/movie',
        queryParameters: {'query': query},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get search movies');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get search movies');
    }
  }

  @override
  Future<void> addId({required String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? idArray = prefs.getStringList('id_array') ?? [];
    idArray.add(id);
    await prefs.setStringList('id_array', idArray);
    developer.log('bookmark ${prefs.getStringList('id_array')}',
        name: 'my.app.category');
  }

  @override
  Future<List<String>?> getIdArray() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('id_array');
  }

  @override
  Future<void> saveIdArray(List<String> idArray) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('id_array', idArray);
  }

  @override
  Future<void> addIdWithDb({required BookmarkMovieModel movie}) async {
    final bookmarkMoviesBox = Hive.box<BookmarkMovieModel>('bookmark');
    try {
      bookmarkMoviesBox.add(movie);
      print('BookmarkTesting, provider add success');
    } catch (e) {
      print('BookmarkTesting, $e');
    }
  }

  @override
  Future<Box<BookmarkMovieModel>> getIdArrayWithDb() async {
    return await Hive.openBox<BookmarkMovieModel>(_bookmarkBox);
  }

  @override
  Future<void> saveIdArrayWithDb(int idArray) async {
    final _dbBox = await Hive.openBox<BookmarkMovieModel>(_bookmarkBox);

    _dbBox.deleteAt(idArray);
  }
}
