part of 'search_movie_cubit.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object?> get props => [];
}

class SearchMovieEmpty extends SearchMovieState {}

class SearchMovieLoading extends SearchMovieState {}

class SearchMovieError extends SearchMovieState {
  final String message;

  const SearchMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchMovieData extends SearchMovieState {
  final List<Movie> result;

  const SearchMovieData(this.result);

  @override
  List<Object?> get props => [result];
}
