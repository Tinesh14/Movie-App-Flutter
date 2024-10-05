import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_test/presentation/pages/movie_detail_page.dart';
import 'package:interview_test/presentation/pages/now_playing_movie_page.dart';
import 'package:interview_test/presentation/pages/search_movie_page.dart';

class Routes {
  Routes._();
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: "/now_playing_movie",
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      /// home page
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/home',
        name: "home",
        builder: (context, state) {
          return const Center(
            child: Text('Ini Page Home'),
          );
        },
      ),

      // now playing movie
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/now_playing_movie',
        name: 'now_playing_movie',
        builder: (context, state) => const NowPlayingMoviePage(),
      ),

      // search movie
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/search_movie',
        name: 'search_movie',
        builder: (context, state) => const SearchMoviePage(),
      ),

      // movie detail
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/movie_detail/:id',
        name: 'movie_detail',
        builder: (context, state) {
          return MovieDetailPage(
            id: int.parse(state.pathParameters["id"] ?? "0"),
          );
        },
      ),
    ],
  );
}
