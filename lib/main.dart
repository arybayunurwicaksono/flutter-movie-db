import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yt_flutter_movie_db/injector.dart';
import 'package:yt_flutter_movie_db/movie/models/bookmark_movie_model.dart';
import 'package:yt_flutter_movie_db/movie/pages/movie_page.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_bookmark_provider.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_discover_provider.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_last_search_provider.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_now_playing_provider.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_top_rated_provider.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_search_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yt_flutter_movie_db/movie/route/app_router.dart';
import 'package:yt_flutter_movie_db/movie/view_model/movie_bookmark_view_model.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setup();
  await Hive.initFlutter();
  Hive.registerAdapter(BookmarkMovieModelAdapter());
  runApp(const App());
  FlutterNativeSplash.remove();
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetDiscoverProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetTopRatedProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetNowPlayingProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieSearchProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetLastSearchProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieBookmarkProvider>(),
        ),
        Provider(
          create: (_) => sl<MovieBookmarkViewModel>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: MaterialApp.router(
          routerConfig: appRouter.config(),
        ),
      ),
    );
  }
}
