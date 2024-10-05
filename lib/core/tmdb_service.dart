import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:interview_test/core/app_constant.dart';
import 'package:interview_test/core/rest_client.dart';
import 'package:interview_test/inject.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@lazySingleton
class TmdbService {
  late RestClient clientMobile;
  late AppConstant constant;

  static final TmdbService _tmdbService = TmdbService._internal();

  TmdbService._internal();

  factory TmdbService() {
    _tmdbService.constant = locator<AppConstant>();
    _tmdbService.clientMobile = _tmdbService.getRestClient();
    return _tmdbService;
  }

  RestClient getRestClient() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 1),
      ),
    );
    dio.options.headers["Authorization"] = "Bearer ${constant.token}";
    dio.options.headers["accept"] = "application/json";
    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
    }
    return RestClient(dio);
  }

  Future getNowPlayingMovies(int page, {String? language}) async =>
      clientMobile.getNowPlaying(page, language ?? 'en-US');

  Future getDetailMovie(String movieId, {String? language}) async =>
      clientMobile.getDetailMovie(movieId, language ?? 'en-US');

  Future searchMovies(String query, {int? page}) async =>
      clientMobile.searchMovies(query, page ?? 1);
}
