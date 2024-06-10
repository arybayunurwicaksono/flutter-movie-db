class BookmarkMovieModel {
  String? backdropPath = "";
  int id;
  String? overview;
  String? posterPath;
  String? title;
  double? voteAverage;
  int? voteCount;

  BookmarkMovieModel({
    required backdropPath,
    required this.id,
    required this.overview,
    this.posterPath,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });
}
