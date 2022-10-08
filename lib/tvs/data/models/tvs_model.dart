import '../../domain/entities/tvs.dart';

class TVModel extends TV {
  const TVModel(
      {required super.id,
      required super.backdropPath,
      required super.originalName,
      required super.overview,
      required super.airDate,
      required super.voteAverage});

  factory TVModel.fromJson(Map<String, dynamic> json) => TVModel(
        id: json['id'],
        backdropPath: json['backdrop_path'],
        originalName: json['original_name'],
        overview: (json['overview'] as String).isNotEmpty
            ? json['overview']
            : "The film, available for free on Vimeo and YouTube, films reflect the cultural norms of a society, but like many trick mirrors, they can distort those norms as well",
        voteAverage: json['vote_average'].toDouble(),
        airDate: json['first_air_date'],
      );
}
