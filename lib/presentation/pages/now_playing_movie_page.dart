import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_test/presentation/cubit/now_playing_movie_cubit.dart';

import '../widgets/card_list.dart';

class NowPlayingMoviePage extends StatefulWidget {
  const NowPlayingMoviePage({super.key});

  @override
  State<NowPlayingMoviePage> createState() => _NowPlayingMoviePageState();
}

class _NowPlayingMoviePageState extends State<NowPlayingMoviePage> {
  NowPlayingMovieCubit? nowPlayingMovieCubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Movies'),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/search_movie');
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          nowPlayingMovieCubit?.fetch(page: 1);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<NowPlayingMovieCubit, NowPlayingMovieState>(
            builder: (context, state) {
              nowPlayingMovieCubit =
                  BlocProvider.of<NowPlayingMovieCubit>(context);
              if (state is NowPlayingMovieLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NowPlayingMovieData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.result[index];
                    return CardList(
                      title: movie.title ?? '',
                      posterPath: movie.posterPath ?? '',
                      overview: movie.overview ?? '',
                      voteAverage: movie.voteAverage ?? 0,
                      releaseDate: movie.releaseDate ?? '',
                      onTap: () {
                        context.pushNamed(
                          'movie_detail',
                          pathParameters: {
                            "id": movie.id.toString(),
                          },
                        );
                      },
                    );
                  },
                  itemCount: state.result.length,
                );
              } else if (state is NowPlayingMovieError) {
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              } else if (state is NowPlayingMovieEmpty) {
                nowPlayingMovieCubit?.fetch();
                return const Center(
                  child: Text('Empty Data'),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
