import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_test/domain/entities/movie.dart';
import 'package:interview_test/presentation/cubit/now_playing_movie_cubit.dart';

import '../../core/constant.dart';
import '../widgets/card_list.dart';

class NowPlayingMoviePage extends StatefulWidget {
  const NowPlayingMoviePage({super.key});

  @override
  State<NowPlayingMoviePage> createState() => _NowPlayingMoviePageState();
}

class _NowPlayingMoviePageState extends State<NowPlayingMoviePage> {
  List<Movie> listMovies = [];
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  bool isLastPage = false;
  bool error = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0 &&
          !isLastPage &&
          !error) {
        page++;
        context.read<NowPlayingMovieCubit>().fetch(page);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

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
          setState(() {
            page = 1;
            isLastPage = false;
            error = false;
          });
          context.read<NowPlayingMovieCubit>().fetch(page);
          listMovies.clear();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<NowPlayingMovieCubit, NowPlayingMovieState>(
            builder: (context, state) {
              if (state is NowPlayingMovieInitial) {
                context.read<NowPlayingMovieCubit>().fetch(page);
              }
              if (state is NowPlayingMovieLoading ||
                  state is NowPlayingMovieInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NowPlayingMovieData) {
                if (page > 1 && error) {
                  error = false;
                }
                listMovies.addAll(state.result);
              } else if (state is NowPlayingMovieError) {
                if (page > 1 && !error) {
                  error = true;
                } else {
                  return Center(
                    key: const Key('error_message'),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(state.message),
                    ),
                  );
                }
              } else if (state is NowPlayingMovieEmpty) {
                return const Center(
                  child: Text('Empty Data'),
                );
              }
              return ListView.builder(
                controller: _scrollController,
                itemCount: listMovies.length + (isLastPage ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index == listMovies.length) {
                    if (error) {
                      return Center(
                        child: SizedBox(
                          height: 180,
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'An error occurred when fetching the movie.',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  // setState(() {

                                  //   // page++; simulation

                                  // });
                                  setState(() {
                                    error = false;
                                  });
                                  context
                                      .read<NowPlayingMovieCubit>()
                                      .fetch(page);
                                },
                                child: const Text(
                                  "Retry",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: kMikadoYellow,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                          child: Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(),
                      ));
                    }
                  }
                  final movie = listMovies[index];
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
              );
            },
            listener: (BuildContext context, NowPlayingMovieState state) {
              if (state is NowPlayingMovieMessage) {
                isLastPage = true;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                  dismissDirection: DismissDirection.horizontal,
                  behavior: SnackBarBehavior.floating,
                  content: Text(state.message),
                  duration: const Duration(seconds: 2),
                ));
              }
            },
          ),
        ),
      ),
    );
  }
}
