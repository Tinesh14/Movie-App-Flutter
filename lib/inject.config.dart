// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/app_constant.dart' as _i78;
import 'core/tmdb_service.dart' as _i185;
import 'data/datasources/remote/movie_remote_data_source.dart' as _i103;
import 'data/datasources/remote/movie_remote_data_source_impl.dart' as _i499;
import 'data/repositories/movie_repository_impl.dart' as _i975;
import 'domain/repositories/movie_repository.dart' as _i477;
import 'domain/usecases/get_movie_detail.dart' as _i594;
import 'domain/usecases/get_now_playing_movies.dart' as _i504;
import 'domain/usecases/search_movies.dart' as _i389;
import 'presentation/cubit/movie_detail_cubit.dart' as _i193;
import 'presentation/cubit/now_playing_movie_cubit.dart' as _i483;
import 'presentation/cubit/search_movie_cubit.dart' as _i448;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i78.AppConstant>(() => _i78.AppConstant());
    gh.lazySingleton<_i185.TmdbService>(() => _i185.TmdbService());
    gh.lazySingleton<_i103.MovieRemoteDataSource>(() =>
        _i499.MovieRemoteDataSourceImpl(service: gh<_i185.TmdbService>()));
    gh.lazySingleton<_i477.MovieRepository>(() => _i975.MovieRepositoryImpl(
        remoteDataSource: gh<_i103.MovieRemoteDataSource>()));
    gh.lazySingleton<_i594.GetMovieDetail>(
        () => _i594.GetMovieDetail(gh<_i477.MovieRepository>()));
    gh.lazySingleton<_i504.GetNowPlayingMovies>(
        () => _i504.GetNowPlayingMovies(gh<_i477.MovieRepository>()));
    gh.lazySingleton<_i389.SearchMovies>(
        () => _i389.SearchMovies(gh<_i477.MovieRepository>()));
    gh.factory<_i448.SearchMovieCubit>(
        () => _i448.SearchMovieCubit(gh<_i389.SearchMovies>()));
    gh.factory<_i483.NowPlayingMovieCubit>(
        () => _i483.NowPlayingMovieCubit(gh<_i504.GetNowPlayingMovies>()));
    gh.factory<_i193.MovieDetailCubit>(
        () => _i193.MovieDetailCubit(gh<_i594.GetMovieDetail>()));
    return this;
  }
}
