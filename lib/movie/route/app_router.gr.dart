// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui';

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:yt_flutter_movie_db/movie/pages/bookmark_page.dart' as _i1;
import 'package:yt_flutter_movie_db/movie/pages/movie_detail_page.dart' as _i2;
import 'package:yt_flutter_movie_db/movie/pages/movie_page.dart' as _i3;
import 'package:yt_flutter_movie_db/movie/pages/movie_pagination_page.dart'
    as _i4;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    BookmarkRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BookmarkPage(),
      );
    },
    MovieDetailRoute.name: (routeData) {
      final args = routeData.argsAs<MovieDetailRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.MovieDetailPage(
          key: args.key,
          id: args.id,
          callback: args.callback,
        ),
      );
    },
    MovieRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.MoviePage(),
      );
    },
    MoviePaginationRoute.name: (routeData) {
      final args = routeData.argsAs<MoviePaginationRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.MoviePaginationPage(
          key: args.key,
          type: args.type,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.BookmarkPage]
class BookmarkRoute extends _i5.PageRouteInfo<void> {
  const BookmarkRoute({List<_i5.PageRouteInfo>? children})
      : super(
          BookmarkRoute.name,
          initialChildren: children,
        );

  static const String name = 'BookmarkRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.MovieDetailPage]
class MovieDetailRoute extends _i5.PageRouteInfo<MovieDetailRouteArgs> {
  MovieDetailRoute({
    _i6.Key? key,
    required int id,
    VoidCallback? callback,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          MovieDetailRoute.name,
          args: MovieDetailRouteArgs(
            key: key,
            id: id,
            callback: callback,
          ),
          initialChildren: children,
        );

  static const String name = 'MovieDetailRoute';

  static const _i5.PageInfo<MovieDetailRouteArgs> page =
      _i5.PageInfo<MovieDetailRouteArgs>(name);
}

class MovieDetailRouteArgs {
  const MovieDetailRouteArgs({
    this.key,
    required this.id,
    this.callback,
  });

  final _i6.Key? key;

  final int id;

  final VoidCallback? callback;

  @override
  String toString() {
    return 'MovieDetailRouteArgs{key: $key, id: $id, callback: $callback}';
  }
}

/// generated route for
/// [_i3.MoviePage]
class MovieRoute extends _i5.PageRouteInfo<void> {
  const MovieRoute({List<_i5.PageRouteInfo>? children})
      : super(
          MovieRoute.name,
          initialChildren: children,
        );

  static const String name = 'MovieRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.MoviePaginationPage]
class MoviePaginationRoute extends _i5.PageRouteInfo<MoviePaginationRouteArgs> {
  MoviePaginationRoute({
    _i6.Key? key,
    required _i4.TypeMovie type,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          MoviePaginationRoute.name,
          args: MoviePaginationRouteArgs(
            key: key,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'MoviePaginationRoute';

  static const _i5.PageInfo<MoviePaginationRouteArgs> page =
      _i5.PageInfo<MoviePaginationRouteArgs>(name);
}

class MoviePaginationRouteArgs {
  const MoviePaginationRouteArgs({
    this.key,
    required this.type,
  });

  final _i6.Key? key;

  final _i4.TypeMovie type;

  @override
  String toString() {
    return 'MoviePaginationRouteArgs{key: $key, type: $type}';
  }
}
