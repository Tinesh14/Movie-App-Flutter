import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:interview_test/core/failure.dart';
import 'package:interview_test/domain/entities/movie.dart';
import 'package:interview_test/domain/repositories/movie_repository.dart';

@lazySingleton
class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(int page) {
    return repository.getNowPlayingMovies(page);
  }
}
