import 'package:equatable/equatable.dart';

class RecommendationMovie extends Equatable {
  final int id;
  final String? backdropPath;

  const RecommendationMovie({required this.id, required this.backdropPath});

  @override
  List<Object?> get props => [id, backdropPath];
}
