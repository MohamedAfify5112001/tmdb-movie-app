import 'package:clean_architature_movie_app/movies/domain/entities/recommendation_movies.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/recommendation_tvs.dart';

class RecommendationTVModel extends RecommendationTVS {
  const RecommendationTVModel({required super.id, required super.backdropPath});

  factory RecommendationTVModel.fromJson(Map<String, dynamic> json) =>
      RecommendationTVModel(
          backdropPath: json['backdrop_path'], id: json['id']);
}
