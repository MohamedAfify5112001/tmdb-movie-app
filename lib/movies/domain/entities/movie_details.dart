import 'package:equatable/equatable.dart';

class MovieDetails extends Equatable {
  final int id;
  final int runtime;
  final String backdropPath;
  final String originalTitle;
  final String overview;
  final List<Genre> genres;
  final String releaseDate;
  final double voteAverage;

  const MovieDetails(
      {required this.id,
      required this.runtime,
      required this.backdropPath,
      required this.originalTitle,
      required this.overview,
      required this.releaseDate,
      required this.voteAverage,
      required this.genres});

  @override
  List<Object?> get props => [
        id,
        runtime,
        backdropPath,
        originalTitle,
        overview,
        releaseDate,
        voteAverage
      ];
}

class Genre extends Equatable {
  final int id;
  final String name;

  const Genre({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
