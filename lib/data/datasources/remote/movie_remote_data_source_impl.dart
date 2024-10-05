import 'package:injectable/injectable.dart';
import 'package:interview_test/core/exception.dart';
import 'package:interview_test/core/tmdb_service.dart';
import 'package:interview_test/data/datasources/remote/movie_remote_data_source.dart';
import 'package:interview_test/data/models/movie_detail_model.dart';
import 'package:interview_test/data/models/movie_model.dart';

@LazySingleton(as: MovieRemoteDataSource)
class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final TmdbService service;
  MovieRemoteDataSourceImpl({required this.service});
  @override
  Future<MovieDetailResponse> getMovieDetail(String id) async {
    final response = await service.getDetailMovie(id);
    if (response != null) {
      return MovieDetailResponse.fromJson(response);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies(int page) async {
    final response = await service.getNowPlayingMovies(page);
    if (response["results"] != null) {
      return List<MovieModel>.from(
          (response["results"] as List).map((x) => MovieModel.fromJson(x)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query, {int? page}) async {
    final response = await service.searchMovies(query, page: page);
    if (response["results"] != null) {
      return List<MovieModel>.from((response.data?["results"] as List)
          .map((x) => MovieModel.fromJson(x)));
    } else {
      throw ServerException();
    }
  }
}
