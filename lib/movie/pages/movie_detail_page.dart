import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:yt_flutter_movie_db/injector.dart';
import 'package:yt_flutter_movie_db/movie/models/bookmark_remove_type.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_bookmark_provider.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_detail_provider.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_videos_provider.dart';
import 'package:yt_flutter_movie_db/movie/view_model/movie_bookmark_view_model.dart';
import 'package:yt_flutter_movie_db/widget/image_widget.dart';
import 'package:yt_flutter_movie_db/widget/item_movie_widget.dart';
import 'package:yt_flutter_movie_db/widget/youtube_player_widget.dart';

@RoutePage()
class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.id, this.callback});

  final int id;
  final VoidCallback? callback;

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late final MovieBookmarkViewModel _movieBookmarkViewModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _movieBookmarkViewModel = Provider.of<MovieBookmarkViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              sl<MovieGetDetailProvider>()..getDetail(context, id: widget.id),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              sl<MovieGetVideosProvider>()..getVideos(context, id: widget.id),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieBookmarkProvider>(),
        ),
      ],
      builder: (_, __) => Scaffold(
        body: CustomScrollView(
          slivers: [
            _WidgetAppBar(
                context, widget.id, _movieBookmarkViewModel, widget.callback),
            Consumer<MovieGetVideosProvider>(
              builder: (_, provider, __) {
                final videos = provider.videos;
                if (videos != null) {
                  return SliverToBoxAdapter(
                    child: _Content(
                      title: 'Trailer',
                      padding: 0,
                      body: SizedBox(
                        height: 160,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            final vidio = videos.results[index];
                            return Stack(
                              children: [
                                ImageNetworkWidget(
                                  radius: 12,
                                  type: TypeSrcImg.external,
                                  imageSrc: YoutubePlayer.getThumbnail(
                                    videoId: vidio.key,
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(
                                          6.0,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 32.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                    child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          _,
                                          MaterialPageRoute(
                                            builder: (_) => YoutubePlayerWidget(
                                              youtubeKey: vidio.key,
                                            ),
                                          ));
                                    },
                                  ),
                                ))
                              ],
                            );
                          },
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemCount: videos.results.length,
                        ),
                      ),
                    ),
                  );
                }
                return const SliverToBoxAdapter();
              },
            ),
            _WidgetSummary(),
          ],
        ),
      ),
    );
  }
}

class _WidgetAppBar extends StatelessWidget {
  final BuildContext context;
  final int movieId;
  final MovieBookmarkViewModel _viewModel;
  final VoidCallback? callback;

  const _WidgetAppBar(
      this.context, this.movieId, this._viewModel, this.callback);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      expandedHeight: 300,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
      ),
      actions: [
        Consumer<MovieGetDetailProvider>(
          builder: (_, provider, __) {
            final movie = provider.movie;
            if (movie != null) {
              return FutureBuilder<bool>(
                future: _viewModel.isBookmarked(movie.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        child: Icon(Icons.bookmark_border),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        child: Icon(Icons.error),
                      ),
                    );
                  } else {
                    bool isBookmark = snapshot.data ?? false;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          child: Observer(
                            builder: (_) {
                              isBookmark = _viewModel.status;
                              return IconButton(
                                  onPressed: () {
                                    if (isBookmark) {
                                      _viewModel.removeBookmarkWithDb(
                                          movie.id.toString(),
                                          BookmarkRemoveType.detail);
                                      const snackBar = SnackBar(
                                        content: Text('Removed from bookmark'),
                                      );
                                      _viewModel.getBookmarkWithDb();

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      try {
                                        callback!();
                                      } catch (e) {
                                        print('bookmarkTesting : $e');
                                      }
                                    } else {
                                      try {
                                        _viewModel.addBookmarkWithDb(movie);
                                        const snackBar = SnackBar(
                                          content: Text('Added to bookmark'),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } catch (e) {
                                        print('bookmarkTesting : $e');
                                      }
                                    }
                                    // Refresh the state to reflect the change
                                    // setState(() {});
                                  },
                                  icon: Observer(
                                      builder: (_) => Icon(_viewModel.status
                                          ? Icons.bookmark
                                          : Icons.bookmark_add_outlined)));
                            },
                          )),
                    );
                  }
                },
              );
            }
            return const SizedBox();
          },
        ),
      ],
      flexibleSpace: Consumer<MovieGetDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;
          if (movie != null) {
            return ItemMovieWidget(
              movieDetail: movie,
              heightBackdrop: double.infinity,
              widthBackdrop: double.infinity,
              heightPoster: 160.0,
              widthPoster: 100.0,
              radius: 0,
            );
          }
          return Container(
            color: Colors.black12,
            height: double.infinity,
            width: double.infinity,
          );
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content(
      {required this.title, required this.body, this.padding = 16.0});

  final String title;
  final Widget body;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            bottom: 8.0,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: body,
        ),
      ],
    );
  }
}

class _WidgetSummary extends StatelessWidget {
  TableRow _tableContent({required String title, required String content}) =>
      TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(content),
        ),
      ]);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieGetDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;
          if (movie != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Content(
                  title: 'Release Date',
                  body: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        size: 32.0,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        movie.releaseDate.toString().split(' ').first,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                _Content(
                  title: 'Genres',
                  body: Wrap(
                    spacing: 6,
                    children: movie.genres
                        .map((genre) => Chip(label: Text(genre.name)))
                        .toList(),
                  ),
                ),
                _Content(title: 'Overview', body: Text(movie.overview)),
                _Content(
                  title: 'Summary',
                  body: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                    },
                    border: TableBorder.all(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    children: [
                      _tableContent(
                          title: "Adult", content: movie.adult ? "Yes" : "No"),
                      _tableContent(
                          title: "Popularity", content: '${movie.popularity}'),
                      _tableContent(title: "Status", content: movie.status),
                      _tableContent(
                          title: "Budget", content: "${movie.budget}"),
                      _tableContent(
                          title: "Revenue", content: "${movie.revenue}"),
                      _tableContent(title: "Tagline", content: movie.tagline),
                    ],
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
