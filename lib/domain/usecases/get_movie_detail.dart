import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:interview_test/domain/entities/movie_detail.dart';
import 'package:interview_test/domain/repositories/movie_repository.dart';

import '../../core/failure.dart';

@lazySingleton
class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getDetailMovie(id.toString());
  }
}
