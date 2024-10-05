import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interview_test/core/failure.dart';
import 'package:interview_test/data/models/movie_detail_model.dart';
import 'package:interview_test/domain/usecases/get_movie_detail.dart';
import 'package:interview_test/presentation/cubit/movie_detail_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MovieDetailCubit movieDetailCubit;
  late MockGetMovieDetail mockGetMovieDetail;
  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailCubit = MovieDetailCubit(mockGetMovieDetail);
  });
  const id = 957452;
  group('Get Movie Detail', () {
    blocTest<MovieDetailCubit, MovieDetailState>(
      'get detail movie success',
      build: () {
        var data = {
          "adult": false,
          "backdrop_path": "/Asg2UUwipAdE87MxtJy7SQo08XI.jpg",
          "belongs_to_collection": null,
          "budget": 50000000,
          "genres": [
            {"id": 28, "name": "Action"},
            {"id": 14, "name": "Fantasy"},
            {"id": 27, "name": "Horror"},
            {"id": 53, "name": "Thriller"},
            {"id": 80, "name": "Crime"}
          ],
          "homepage": "https://thecrow.movie/",
          "id": 957452,
          "imdb_id": "tt1340094",
          "origin_country": ["US"],
          "original_language": "en",
          "original_title": "The Crow",
          "overview":
              "Soulmates Eric and Shelly are brutally murdered when the demons of her dark past catch up with them. Given the chance to save his true love by sacrificing himself, Eric sets out to seek merciless revenge on their killers, traversing the worlds of the living and the dead to put the wrong things right.",
          "popularity": 1208.652,
          "poster_path": "/58QT4cPJ2u2TqWZkterDq9q4yxQ.jpg",
          "production_companies": [
            {
              "id": 342,
              "logo_path": "/kZ99mxyNvNgyAFjm7rcl9vfYmU8.png",
              "name": "Davis Films",
              "origin_country": "FR"
            },
            {
              "id": 6455,
              "logo_path": "/mc3rMk0tW5ajjbfqkB8xlp85Cdy.png",
              "name": "Pressman Film",
              "origin_country": "US"
            },
            {
              "id": 51526,
              "logo_path": null,
              "name": "Hassell Free Production",
              "origin_country": "US"
            },
            {
              "id": 67260,
              "logo_path": "/oV2FZfhRcEc1HReC66e1L4t2qPV.png",
              "name": "The Electric Shadow Company",
              "origin_country": "GB"
            },
            {
              "id": 104363,
              "logo_path": "/tKIimrvYUH02D4km00lCEDUYvIF.png",
              "name": "30WEST",
              "origin_country": "US"
            },
            {
              "id": 189103,
              "logo_path": "/hu0qcD4k7kfWpdAewqmJSUyZPa7.png",
              "name": "Ashland Hill Media Finance",
              "origin_country": "US"
            }
          ],
          "production_countries": [
            {"iso_3166_1": "FR", "name": "France"},
            {"iso_3166_1": "GB", "name": "United Kingdom"},
            {"iso_3166_1": "US", "name": "United States of America"}
          ],
          "release_date": "2024-08-21",
          "revenue": 13690814,
          "runtime": 111,
          "spoken_languages": [
            {"english_name": "English", "iso_639_1": "en", "name": "English"}
          ],
          "status": "Released",
          "tagline": "True love never dies.",
          "title": "The Crow",
          "video": false,
          "vote_average": 5.474,
          "vote_count": 472
        };
        var movieDetail = MovieDetailResponse.fromJson(data).toEntity();
        when(mockGetMovieDetail.execute(id))
            .thenAnswer((_) async => Right(movieDetail));
        return movieDetailCubit;
      },
      act: (bloc) => bloc.fetch(id),
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(id));
      },
      expect: () => [
        isA<MovieDetailLoading>(),
        isA<MovieDetailData>(),
      ],
    );

    blocTest(
      'get detail movie failed',
      build: () {
        when(mockGetMovieDetail.execute(id)).thenAnswer(
            (_) async => const Left(ServerFailure('Something Went Wrong')));
        return movieDetailCubit;
      },
      act: (bloc) => bloc.fetch(id),
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(id));
      },
      expect: () => [
        isA<MovieDetailLoading>(),
        isA<MovieDetailError>(),
      ],
    );
  });
}
