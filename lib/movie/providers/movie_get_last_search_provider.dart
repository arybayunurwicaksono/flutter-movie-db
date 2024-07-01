import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_model.dart';
import 'package:yt_flutter_movie_db/movie/repository/movie_repository.dart';

class MovieGetLastSearchProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetLastSearchProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void getLastSearchWithPaging(
    BuildContext context, {
    required String query,
    required int page,
    required PagingController pagingController,
  }) async {
    final result =
        await _movieRepository.getLastSearch(query: query, page: page);

    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));
        pagingController.error = errorMessage;
        return;
      },
      (response) {
        if (response.results.length < 20) {
          pagingController.appendLastPage(response.results);
        } else {
          pagingController.appendPage(response.results, page + 1);
        }
        return null;
      },
    );
  }
}
