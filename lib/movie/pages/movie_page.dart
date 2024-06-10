import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_flutter_movie_db/movie/components/movie_discover_component.dart';
import 'package:yt_flutter_movie_db/movie/components/movie_now_playing_component.dart';
import 'package:yt_flutter_movie_db/movie/components/movie_top_rated_component.dart';
import 'package:yt_flutter_movie_db/movie/pages/bookmark_page.dart';
import 'package:yt_flutter_movie_db/movie/pages/movie_pagination_page.dart';
import 'package:yt_flutter_movie_db/movie/pages/movie_search_page.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_discover_provider.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MovieGetDiscoverProvider>().getDiscover(context);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/images/tmdb_logo.png'),
                ),
              ),
              const Text('Movie DB')
            ],
          ),
          actions: [
            IconButton(
              onPressed: () => showSearch(
                context: context,
                delegate: MovieSearchPage(),
              ),
              icon: const Icon(Icons.search),
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookmarkPage(),
                ),
              );
            },
          ),
          floating: true,
          snap: true,
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        _WidgetTitle(
          title: 'Discover Movies',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MoviePaginationPage(
                  type: TypeMovie.discover,
                ),
              ),
            );
          },
        ),
        const MovieDiscoverComponent(),
        _WidgetTitle(
          title: 'Top Rated Movies',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MoviePaginationPage(
                  type: TypeMovie.topRated,
                ),
              ),
            );
          },
        ),
        const MovieTopRatedComponent(),
        _WidgetTitle(
          title: 'Now Playing Movies',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MoviePaginationPage(
                  type: TypeMovie.nowPlaying,
                ),
              ),
            );
          },
        ),
        const MovieNowPlayingComponent(),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 10.0,
          ),
        ),
      ],
    ));
  }
}

class _WidgetTitle extends SliverToBoxAdapter {
  final String title;
  final void Function() onPressed;

  const _WidgetTitle({required this.title, required this.onPressed});

  @override
  // TODO: implement child
  Widget? get child => Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                shape: StadiumBorder(),
                side: BorderSide(
                  color: Colors.black54,
                ),
              ),
              child: Text("See All"),
            ),
          ],
        ),
      );
}
