import 'package:clean_architature_movie_app/tvs/domain/entities/season.dart';

class SeasonModel extends Season {
  SeasonModel({required super.id, required super.episodes, super.isExpanded});

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
      id: json["id"],
      isExpanded: false,
      episodes: List<EpisodeModel>.from((json["episodes"] as List)
          .map((episode) => EpisodeModel.fromJson(episode))));
}

class EpisodeModel extends Episode {
  const EpisodeModel(
      {required super.name,
      required super.overview,
      required super.stillPath,
      required super.airDate,
      required super.id});

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
      id: json["id"],
      name: json["name"],
      overview: json["overview"],
      stillPath: json["still_path"],
      airDate: json['air_date']);
}
