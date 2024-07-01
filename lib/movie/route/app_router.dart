import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: BookmarkRoute.page),
        AutoRoute(page: MovieRoute.page, initial: true),
        AutoRoute(page: MovieDetailRoute.page),
        AutoRoute(page: MoviePaginationRoute.page),
      ];
}
