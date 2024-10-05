import 'package:equatable/equatable.dart';
import 'package:interview_test/data/models/genre_model.dart';
import 'package:interview_test/domain/entities/movie_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieDetailResponse extends Equatable {
  const MovieDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  @JsonKey(name: "backdrop_path")
  final String? backdropPath;
  final int budget;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  @JsonKey(name: "imdb_id")
  final String? imdbId;
  @JsonKey(name: "origin_country")
  final List<String> originCountry;
  @JsonKey(name: "original_language")
  final String originalLanguage;
  @JsonKey(name: "original_title")
  final String originalTitle;
  final String overview;
  final double popularity;
  @JsonKey(name: "poster_path")
  final String posterPath;
  @JsonKey(name: "release_date")
  final String releaseDate;
  final int revenue;
  final int runtime;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  @JsonKey(name: "vote_average")
  final double voteAverage;
  @JsonKey(name: "vote_count")
  final int voteCount;

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailResponseToJson(this);

  MovieDetail toEntity() {
    return MovieDetail(
      adult: adult,
      backdropPath: backdropPath,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      originalTitle: originalTitle,
      overview: overview,
      posterPath: posterPath,
      releaseDate: releaseDate,
      runtime: runtime,
      title: title,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        budget,
        genres,
        homepage,
        id,
        imdbId,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        revenue,
        runtime,
        status,
        tagline,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}
