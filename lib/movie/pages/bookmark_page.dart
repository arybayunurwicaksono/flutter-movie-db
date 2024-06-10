import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:yt_flutter_movie_db/injector.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_model.dart';
import 'package:yt_flutter_movie_db/movie/pages/movie_detail_page.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_bookmark_provider.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_detail_provider.dart';
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
          final result = provider.movie;
          if (result != null && result.isNotEmpty) {
            return ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, index) {
                String movieId = result[index];
                return ChangeNotifierProvider(
                  create: (_) => sl<MovieGetDetailProvider>()
                    ..getDetail(context, id: int.parse(movieId)),
                  child: Consumer<MovieGetDetailProvider>(
                    builder: (_, detailProvider, __) {
                      final movie = detailProvider.movie;
                      if (movie != null) {
                        final item = MovieModel(
                          backdropPath: movie.backdropPath,
                          id: movie.id,
                          overview: movie.overview,
                          posterPath: movie.posterPath,
                          title: movie.title,
                          voteAverage: movie.voteAverage,
                          voteCount: movie.voteCount,
                        );
                        return Slidable(
                          key: Key(item.id.toString()),
                          endActionPane: ActionPane(
                            motion: const BehindMotion(),
                            children: [
                              SlidableAction(
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                label: 'Delete',
                                onPressed: (context) {
                                  provider.removeBookmark(movieId);
                                  setState(() {
                                    provider.movie!.removeAt(index);
                                  });
                                  _onDismissed(context);
                                },
                              ),
                            ],
                          ),
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: ItemMovieWidget(
                              movie: item,
                              heightBackdrop: 300.0,
                              widthBackdrop: double.infinity,
                              heightPoster: 160.0,
                              widthPoster: 100.0,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return MovieDetailPage(id: movie.id);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
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
