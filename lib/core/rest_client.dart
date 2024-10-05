import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/http.dart';
part 'rest_client.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/movie/now_playing')
  Future getNowPlaying(
    @Query("page") int page,
    @Query("language") String language,
  );

  @GET('/movie/{movie_id}')
  Future getDetailMovie(
    @Path("movie_id") String movieId,
    @Query("language") String language,
  );

  @GET('/search/movie')
  Future searchMovies(
    @Query('query') String query,
    @Query('page') int page, {
    @Query('include_adult') bool includeAdult = false,
    @Query("language") String language = "en-US",
    @Query('primary_release_year') String? primaryReleaseYear,
    @Query('region') String? region,
    @Query('year') String? year,
  });
}

class ParseErrorLogger {
  logError(e, s, options) {
    debugPrint('ParseErrorLogger e: $e');
  }
}
