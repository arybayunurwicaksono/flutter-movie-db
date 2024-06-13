import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_model.dart';
import 'package:yt_flutter_movie_db/movie/pages/movie_detail_page.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_bookmark_provider.dart';
import 'package:yt_flutter_movie_db/widget/item_movie_widget.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieBookmarkProvider>(context, listen: false).getBookmark();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
      ),
      body: Consumer<MovieBookmarkProvider>(
        builder: (_, provider, __) {
          provider.getBookmarkWithDb();
          final result = provider.movieDb;
          if (result != null && result.isNotEmpty) {
            return ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, index) {
                String movieId = result.getAt(index).toString();
                return Slidable(
                  key: Key(movieId),
                  endActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        label: 'Delete',
                        onPressed: (context) {
                          provider.removeBookmarkWithDb(index.toString());
                          _onDismissed(context);
                        },
                      ),
                    ],
                  ),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: ItemMovieWidget(
                      movie: MovieModel(
                        id: result.getAt(index)!.id,
                        backdropPath: result.getAt(index)!.backdropPath,
                        posterPath: result.getAt(index)!.posterPath,
                        overview: '',
                        title: result.getAt(index)!.title!,
                        voteAverage: result.getAt(index)!.voteAverage!,
                        voteCount: result.getAt(index)!.voteCount!,
                      ),
                      heightBackdrop: 300.0,
                      widthBackdrop: double.infinity,
                      heightPoster: 160.0,
                      widthPoster: 100.0,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return MovieDetailPage(
                                  id: result.getAt(index)!.id);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }

          return Center(
            child: Text('No Bookmarked Movies, $result'),
          );
        },
      ),
    );
  }
}

void _onDismissed(BuildContext context) {
  const snackBar = SnackBar(
    content: Text('Deleted'),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
