part of 'now_playing_movie_cubit.dart';

abstract class NowPlayingMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NowPlayingMovieInitial extends NowPlayingMovieState {}

class NowPlayingMovieEmpty extends NowPlayingMovieState {}

class NowPlayingMovieLoading extends NowPlayingMovieState {}

class NowPlayingMovieData extends NowPlayingMovieState {
  final List<Movie> result;

  NowPlayingMovieData(this.result);

  @override
  List<Object?> get props => [result];
}

class NowPlayingMovieError extends NowPlayingMovieState {
  final String message;

  NowPlayingMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class NowPlayingMovieMessage extends NowPlayingMovieState {
  final String message;

  NowPlayingMovieMessage(this.message);

  @override
  List<Object?> get props => [message];
}
