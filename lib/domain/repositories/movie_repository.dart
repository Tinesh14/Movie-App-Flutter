import 'package:dartz/dartz.dart';
import 'package:interview_test/core/failure.dart';
import 'package:interview_test/domain/entities/movie.dart';
import 'package:interview_test/domain/entities/movie_detail.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies(int page,
      {String? language});
  Future<Either<Failure, MovieDetail>> getDetailMovie(String id,
      {String? language});
  Future<Either<Failure, List<Movie>>> searchMovies(String query, {int? page});
}
