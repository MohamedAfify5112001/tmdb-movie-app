import 'package:equatable/equatable.dart';

class Season extends Equatable {
  final int id;
  final List<Episode> episodes;
  bool isExpanded;

  Season({required this.id, required this.episodes, this.isExpanded = false});

  @override
  List<Object> get props => [id, episodes];
}

class Episode extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String? stillPath;
  final String airDate;

  const Episode(
      {required this.name,
      required this.overview,
      required this.stillPath,
      required this.airDate,
      required this.id});

  @override
  List<Object?> get props => [id, name, overview, stillPath, airDate];
}
