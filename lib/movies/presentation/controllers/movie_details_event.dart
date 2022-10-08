part of 'movie_details_bloc.dart';

@immutable
abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();
}

class GetMovieDetailsEvent extends MovieDetailsEvent {
  final int movieId;

  const GetMovieDetailsEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class GetRecommendationMoviesEvent extends MovieDetailsEvent {
  final int movieId;

  const GetRecommendationMoviesEvent(this.movieId);

  @override
  List<Object?> get props => [movieId];
}
