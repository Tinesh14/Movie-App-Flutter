import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:interview_test/domain/entities/movie.dart';
import 'package:interview_test/domain/usecases/search_movies.dart';

part 'search_movie_state.dart';

@injectable
class SearchMovieCubit extends Cubit<SearchMovieState> with HydratedMixin {
  final SearchMovies searchMovies;
  SearchMovieCubit(this.searchMovies) : super(SearchMovieEmpty()) {
    hydrate();
  }

  search(String query) async {
    try {
      emit(SearchMovieLoading());
      final result = await searchMovies.execute(query);
      result.fold(
        (failure) => emit(SearchMovieError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(SearchMovieEmpty());
          } else {
            emit(SearchMovieData(data));
          }
        },
      );
    } catch (e) {
      emit(const SearchMovieError('error try catch'));
    }
  }

  @override
  SearchMovieState? fromJson(Map<String, dynamic> json) {
    debugPrint('fromJson hydrated search movie: $json');

    try {
      if (json['movies'] != null) {
        final movies = (json['movies'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();
        return SearchMovieData(movies);
      }
      return SearchMovieEmpty();
    } catch (e) {
      debugPrint('Error deserializing: $e');
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(SearchMovieState state) {
    debugPrint('toJson hydrated search movie: $state');
    if (state is SearchMovieData) {
      return {
        'movies': state.result.map((movie) => movie.toJson()).toList(),
      };
    }
    return null;
  }
}
