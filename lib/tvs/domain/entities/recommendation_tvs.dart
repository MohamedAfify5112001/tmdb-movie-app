import 'package:equatable/equatable.dart';

class RecommendationTVS extends Equatable {
  final int id;
  final String? backdropPath;

  const RecommendationTVS({required this.id, required this.backdropPath});

  @override
  List<Object?> get props => [id, backdropPath];
}
