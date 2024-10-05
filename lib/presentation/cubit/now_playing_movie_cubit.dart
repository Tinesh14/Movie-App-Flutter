import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:interview_test/domain/usecases/get_now_playing_movies.dart';

import '../../domain/entities/movie.dart';

part 'now_playing_movie_state.dart';

@injectable
class NowPlayingMovieCubit extends Cubit<NowPlayingMovieState>
    with HydratedMixin {
  final GetNowPlayingMovies getNowPlayingMovies;
  NowPlayingMovieCubit(this.getNowPlayingMovies)
      : super(NowPlayingMovieEmpty()) {
    hydrate();
  }

  fetch({int? page}) async {
    try {
      emit(NowPlayingMovieLoading());
      final result = await getNowPlayingMovies.execute(page ?? 1);
      result.fold(
        (failure) => emit(NowPlayingMovieError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(NowPlayingMovieEmpty());
          } else {
            emit(NowPlayingMovieData(data));
          }
        },
      );
    } catch (e) {
      emit(NowPlayingMovieError('error try catch'));
    }
  }

  @override
  NowPlayingMovieState? fromJson(Map<String, dynamic> json) {
    debugPrint('fromJson hydrated now playing movie: $json');
    try {
      if (json['movies'] != null) {
        final movies = (json['movies'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();
        return NowPlayingMovieData(movies);
      }
      return NowPlayingMovieEmpty();
    } catch (e) {
      debugPrint('Error deserializing: $e');
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(NowPlayingMovieState state) {
    debugPrint('toJson hydrated now playing movie: $state');
    if (state is NowPlayingMovieData) {
      return {
        'movies': state.result.map((movie) => movie.toJson()).toList(),
      };
    }
    return null;
  }
}
