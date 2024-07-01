import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_model.dart';
import 'package:yt_flutter_movie_db/movie/pages/movie_detail_page.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_discover_provider.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_last_search_provider.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_now_playing_provider.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_top_rated_provider.dart';
import 'package:yt_flutter_movie_db/movie/route/app_router.gr.dart';
import 'package:yt_flutter_movie_db/widget/item_movie_widget.dart';

enum TypeMovie { discover, topRated, nowPlaying, lastSearch }

@RoutePage()
class MoviePaginationPage extends StatefulWidget {
  const MoviePaginationPage({super.key, required this.type, this.query});

  final TypeMovie type;

  final String? query;

  @override
  State<MoviePaginationPage> createState() => _MoviePaginationPageState();
}

class _MoviePaginationPageState extends State<MoviePaginationPage> {
  final PagingController<int, MovieModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      switch (widget.type) {
        case TypeMovie.discover:
          context.read<MovieGetDiscoverProvider>().getDiscoverWithPaging(
              context,
              page: pageKey,
              pagingController: _pagingController);
          break;
        case TypeMovie.topRated:
          context.read<MovieGetTopRatedProvider>().getTopRatedWithPaging(
              context,
              page: pageKey,
              pagingController: _pagingController);
          break;
        case TypeMovie.nowPlaying:
          context.read<MovieGetNowPlayingProvider>().getNowPlayingWithPaging(
              context,
              page: pageKey,
              pagingController: _pagingController);
          break;
        case TypeMovie.lastSearch:
          context.read<MovieGetLastSearchProvider>().getLastSearchWithPaging(
              context,
              query: widget.query!,
              page: pageKey,
              pagingController: _pagingController);
          break;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (context) {
          switch (widget.type) {
            case TypeMovie.discover:
              return const Text('Discover Movies');
            case TypeMovie.topRated:
              return const Text('Top Rated Movies');
            case TypeMovie.nowPlaying:
              return const Text('Now Playing Movies');
            case TypeMovie.lastSearch:
              return const Text('Last Search');
          }
        }),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black38,
        elevation: 0.5,
      ),
      body: PagedListView.separated(
        padding: EdgeInsets.all(16.0),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<MovieModel>(
          itemBuilder: (context, item, index) => ItemMovieWidget(
            movie: item,
            heightBackdrop: 300.0,
            widthBackdrop: double.infinity,
            heightPoster: 160.0,
            widthPoster: 100.0,
            onTap: () {
              AutoRouter.of(context).push(MovieDetailRoute(id: item.id));
            },
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
