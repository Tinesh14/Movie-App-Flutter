import 'package:interview_test/data/models/movie_detail_model.dart';
import 'package:interview_test/data/models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies(int page);
  Future<MovieDetailResponse> getMovieDetail(String id);
  Future<List<MovieModel>> searchMovies(String query);
}
