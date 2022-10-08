import 'package:clean_architature_movie_app/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel(
      {required super.id,
      required super.releaseDate,
      required super.backdropPath,
      required super.originalTitle,
      required super.overview,
      required super.voteAverage,
      required super.genreIds});

  factory MovieModel.formJson(Map<String, dynamic> json) => MovieModel(
        id: json['id'],
        releaseDate: json['release_date'],
        backdropPath: json['backdrop_path'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        voteAverage: json['vote_average'].toDouble(),
        genreIds: List<int>.from(
            (json['genre_ids'] as List).map((genreId) => genreId)),
      );
}
