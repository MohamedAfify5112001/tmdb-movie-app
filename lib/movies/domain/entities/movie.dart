import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String backdropPath;
  final String originalTitle;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final List<int> genreIds;

  const Movie(
      {required this.id,
      required this.releaseDate,
      required this.backdropPath,
      required this.originalTitle,
      required this.overview,
      required this.voteAverage,
      required this.genreIds});

  @override
  List<Object> get props => [
        id,
        backdropPath,
        originalTitle,
        overview,
        releaseDate,
        voteAverage,
        genreIds,
      ];
}
