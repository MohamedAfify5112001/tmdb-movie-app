import '../../domain/entities/movie_details.dart';

class MovieDetailsModel extends MovieDetails {
  const MovieDetailsModel(
      {required super.id,
      required super.runtime,
      required super.backdropPath,
      required super.originalTitle,
      required super.overview,
      required super.releaseDate,
      required super.voteAverage,
      required super.genres});

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailsModel(
        id: json['id'],
        releaseDate: json['release_date'],
        backdropPath: json['backdrop_path'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        voteAverage: json['vote_average'].toDouble(),
        genres: List<Genre>.from((json['genres'] as List)
            .map((genre) => GenreModel.fromJson(genre))),
        runtime: json['runtime'],
      );
}

class GenreModel extends Genre {
  const GenreModel({required super.id, required super.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      GenreModel(id: json['id'], name: json['name']);
}
