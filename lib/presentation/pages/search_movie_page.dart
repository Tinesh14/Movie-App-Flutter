import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_test/core/constant.dart';
import 'package:interview_test/presentation/cubit/search_movie_cubit.dart';
import 'package:interview_test/presentation/widgets/card_list.dart';

class SearchMoviePage extends StatefulWidget {
  const SearchMoviePage({super.key});

  @override
  State<SearchMoviePage> createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  SearchMovieCubit? searchMovieCubit;
  Timer? _debounce;
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Search Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              // onSubmitted: (value) {
              //   searchMovieCubit?.search(value);
              //   debugPrint('onSubmitted: $value');
              // },
              onChanged: (value) {
                if (_debounce?.isActive ?? false) {
                  _debounce?.cancel();
                }
                _debounce = Timer(
                  const Duration(milliseconds: 500),
                  () {
                    searchMovieCubit?.search(value);
                    debugPrint('onChanged: $value');
                  },
                );
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            BlocBuilder<SearchMovieCubit, SearchMovieState>(
              builder: (context, state) {
                searchMovieCubit = BlocProvider.of<SearchMovieCubit>(context);
                if (state is SearchMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchMovieData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = result[index];
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
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchMovieEmpty) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Search Not Found', style: kSubtitle),
                        ],
                      ),
                    ),
                  );
                } else if (state is SearchMovieError) {
                  return Expanded(
                    child: Center(
                      key: const Key('error_message'),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(state.message),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
