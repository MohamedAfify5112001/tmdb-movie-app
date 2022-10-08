import 'package:clean_architature_movie_app/movies/domain/entities/recommendation_movies.dart';

class RecommendationMovieModel extends RecommendationMovie {
  const RecommendationMovieModel(
      {required super.id, required super.backdropPath});

  factory RecommendationMovieModel.fromJson(Map<String, dynamic> json) =>
      RecommendationMovieModel(
          backdropPath: json['backdrop_path'], id: json['id']);
}
