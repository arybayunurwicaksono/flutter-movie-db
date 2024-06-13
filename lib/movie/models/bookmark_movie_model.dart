import 'package:hive/hive.dart';

part 'bookmark_movie_model.g.dart';

@HiveType(typeId: 1)
class BookmarkMovieModel extends HiveObject {
  @HiveField(0)
  String? backdropPath = "";

  @HiveField(1)
  late int id;

  @HiveField(2)
  String? posterPath;

  @HiveField(3)
  String? title;

  @HiveField(4)
  double? voteAverage;

  @HiveField(5)
  int? voteCount;

  BookmarkMovieModel({
    this.backdropPath,
    required this.id,
    this.posterPath,
    this.title,
    this.voteAverage,
    this.voteCount,
  });

  @override
  String toString() {
    return 'BookmarkMovie{id: $id, title: $title}';
  }
}




// class BookmarkMovieModel {
//   String? backdropPath = "";
//   int id;
//   String? posterPath;
//   String? title;
//   double? voteAverage;
//   int? voteCount;

//   BookmarkMovieModel({
//     required backdropPath,
//     required this.id,
//     this.posterPath,
//     required this.title,
//     required this.voteAverage,
//     required this.voteCount,
//   });
// }
