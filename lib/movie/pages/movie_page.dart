import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yt_flutter_movie_db/movie/components/movie_discover_component.dart';
import 'package:yt_flutter_movie_db/movie/components/movie_now_playing_component.dart';
import 'package:yt_flutter_movie_db/movie/components/movie_top_rated_component.dart';
import 'package:yt_flutter_movie_db/movie/pages/bookmark_page.dart';
import 'package:yt_flutter_movie_db/movie/pages/movie_pagination_page.dart';
import 'package:yt_flutter_movie_db/movie/pages/movie_search_page.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_discover_provider.dart';
import 'package:yt_flutter_movie_db/movie/route/app_router.gr.dart';
import 'package:yt_flutter_movie_db/movie/view_model/movie_bookmark_view_model.dart';

@RoutePage()
class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late final MovieBookmarkViewModel _viewModel;
  String? searchQuery;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().getDiscover(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = Provider.of<MovieBookmarkViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
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
                      child: SvgPicture.asset(
                        "assets/images/Kecilin-white.svg",
                        color: Colors.black,
                        width: 40,
                        height: 40,
                      )),
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
                AutoRouter.of(context).push(const BookmarkRoute());
              },
            ),
            floating: true,
            snap: true,
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          SliverToBoxAdapter(
            child: Observer(
              builder: (_) {
                _viewModel.getEncryptedData;
                if (_viewModel.searchQuery! == "" ||
                    _viewModel.searchQuery!.isEmpty) {
                  return const SizedBox(
                    height: 10.0,
                  );
                }
                return Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Search \"${_viewModel.searchQuery!}\" again',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MoviePaginationPage(
                                type: TypeMovie.lastSearch,
                                query: _viewModel.searchQuery,
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          shape: StadiumBorder(),
                          side: BorderSide(
                            color: Colors.black54,
                          ),
                        ),
                        child: const Text("Go"),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Row(
            //   children: [
            //     Observer(
            //       builder: (_) {
            //         _viewModel.getEncryptedData;
            //         if (_viewModel.searchQuery!.isEmpty ||
            //             _viewModel.searchQuery! == "") {
            //           return const SliverToBoxAdapter(
            //             child: SizedBox(
            //               height: 0.0,
            //             ),
            //           );
            //         } else {
            //           return Text(
            //             'Search \"${_viewModel.searchQuery!}\" again',
            //             style: const TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18.0,
            //             ),
            //           );
            //         }
            //       },
            //     ),
            //     OutlinedButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (_) => const MoviePaginationPage(
            //               type: TypeMovie.lastSearch,
            //             ),
            //           ),
            //         );
            //       },
            //       style: OutlinedButton.styleFrom(
            //         foregroundColor: Colors.black,
            //         shape: StadiumBorder(),
            //         side: BorderSide(
            //           color: Colors.black54,
            //         ),
            //       ),
            //       child: const Text("Go"),
            //     ),
            //   ],
            // ),
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
      ),
    );
  }
}

class _WidgetTitle extends SliverToBoxAdapter {
  final String title;
  final void Function() onPressed;

  const _WidgetTitle({required this.title, required this.onPressed});

  @override
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
