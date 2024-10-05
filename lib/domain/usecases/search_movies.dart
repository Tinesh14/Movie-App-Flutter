import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:interview_test/core/failure.dart';
import 'package:interview_test/domain/entities/movie.dart';
import 'package:interview_test/domain/repositories/movie_repository.dart';

@lazySingleton
class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query, {int? page}) {
    return repository.searchMovies(query, page: page);
  }
}
