// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_results_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieResultsModel _$MovieResultsModelFromJson(Map<String, dynamic> json) =>
    MovieResultsModel(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalResults: (json['total_results'] as num).toInt(),
      dates: json['dates'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$MovieResultsModelToJson(MovieResultsModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
      'dates': instance.dates,
    };
