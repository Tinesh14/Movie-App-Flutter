import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'movie_model.dart';

part 'movie_results_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieResultsModel extends Equatable {
  const MovieResultsModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
    required this.dates,
  });
  final int page;
  final List<MovieModel> results;
  @JsonKey(name: "total_pages")
  final int totalPages;
  @JsonKey(name: "total_results")
  final int totalResults;
  final Map? dates;

  factory MovieResultsModel.fromJson(Map<String, dynamic> json) =>
      _$MovieResultsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResultsModelToJson(this);
  @override
  List<Object> get props => [page, results, totalPages, totalResults];
}
