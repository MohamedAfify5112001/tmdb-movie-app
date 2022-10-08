import 'package:clean_architature_movie_app/tvs/domain/entities/genre_tv.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/tv_details.dart';

class TVDetailsModel extends TVDetails {
  const TVDetailsModel(
      {required super.id,
      required super.backdropPath,
      required super.originalName,
      required super.overview,
      required super.sessionNumber,
      required super.episodeRuntime,
      required super.genres,
      required super.airDate,
      required super.voteAverage});

  factory TVDetailsModel.fromJson(Map<String, dynamic> json) => TVDetailsModel(
      id: json['id'],
      backdropPath: json['backdrop_path'],
      originalName: json['original_name'],
      overview: (json['overview'] as String).isNotEmpty
          ? json['overview']
          : "The film, available for free on Vimeo and YouTube, films reflect the cultural norms of a society, but like many trick mirrors, they can distort those norms as well",
      voteAverage: json['vote_average'].toDouble(),
      airDate: json['first_air_date'],
      genres: (json['genres'] as List)
          .map((genre) => GenreTVModel.fromJson(genre))
          .toList(),
      sessionNumber: json['number_of_seasons'],
      episodeRuntime: List<int>.from(
        (json['episode_run_time'] as List).isNotEmpty
            ? (json['episode_run_time'] as List).map((runtime) => runtime)
            : [50].map((e) => e),
      ));
}

class GenreTVModel extends GenreTV {
  const GenreTVModel({required super.id, required super.name});

  factory GenreTVModel.fromJson(Map<String, dynamic> json) =>
      GenreTVModel(id: json['id'], name: json['name']);
}
