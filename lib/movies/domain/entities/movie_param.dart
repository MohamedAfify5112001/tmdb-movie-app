import 'package:equatable/equatable.dart';

class MovieParam extends Equatable {
  final int movieId;

  const MovieParam(this.movieId);

  @override
  List<Object> get props => [movieId];
}