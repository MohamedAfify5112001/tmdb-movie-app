import 'package:equatable/equatable.dart';

class TV extends Equatable {
  final int id;
  final String? backdropPath;
  final String originalName;

  final String overview;
  final String airDate;
  final double voteAverage;

  const TV(
      {required this.id,
      required this.backdropPath,
      required this.originalName,
      required this.overview,
      required this.airDate,
      required this.voteAverage});

  @override
  List<Object?> get props => [id, backdropPath, originalName];
}
