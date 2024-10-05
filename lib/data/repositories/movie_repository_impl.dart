import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:interview_test/core/failure.dart';
import 'package:interview_test/domain/entities/movie.dart';
import 'package:interview_test/domain/entities/movie_detail.dart';
import 'package:interview_test/domain/repositories/movie_repository.dart';

import '../../core/exception.dart';
import '../datasources/remote/movie_remote_data_source.dart';

@LazySingleton(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  MovieRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, MovieDetail>> getDetailMovie(String id,
      {String? language}) async {
    try {
      final result = await remoteDataSource.getMovieDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies(int page,
      {String? language}) async {
    try {
      final result = await remoteDataSource.getNowPlayingMovies(page);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(String query,
      {int? page}) async {
    try {
      final result = await remoteDataSource.searchMovies(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
