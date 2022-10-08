import 'package:clean_architature_movie_app/tvs/domain/entities/genre_tv.dart';
import 'package:equatable/equatable.dart';

class TVDetails extends Equatable {
  final int id;
  final int sessionNumber;
  final List<int> episodeRuntime;
  final String? backdropPath;
  final String originalName;
  final List<GenreTV> genres;
  final String overview;
  final String airDate;
  final double voteAverage;

  const TVDetails(
      {required this.id,
      required this.backdropPath,
      required this.originalName,
      required this.overview,
      required this.sessionNumber,
      required this.episodeRuntime,
      required this.genres,
      required this.airDate,
      required this.voteAverage});

  @override
  List<Object?> get props => [
        id,
        sessionNumber,
        episodeRuntime,
        backdropPath,
        originalName,
        genres,
        overview,
        airDate,
        voteAverage,
      ];
}
