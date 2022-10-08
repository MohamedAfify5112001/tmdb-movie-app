part of 'movie_details_bloc.dart';

@immutable
abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();
}

class MovieDetailsInitial extends MovieDetailsState {
  @override
  List<Object> get props => [];
}

class GetMovieDetailsLoadingState extends MovieDetailsState {
  @override
  List<Object> get props => [];
}

class GetMovieDetailsLoadedState extends MovieDetailsState {
  final MovieDetails movieDetails;

  const GetMovieDetailsLoadedState(this.movieDetails);

  @override
  List<Object> get props => [movieDetails];
}

class GetMovieDetailsFailedState extends MovieDetailsState {
  final String message;

  const GetMovieDetailsFailedState(this.message);

  @override
  List<Object> get props => [message];
}

class GetRecommendationMovieLoadingState extends MovieDetailsState {
  @override
  List<Object> get props => [];
}

class GetRecommendationMovieLoadedState extends MovieDetailsState {
  final List<RecommendationMovie> recommendationMovie;

  const GetRecommendationMovieLoadedState(this.recommendationMovie);

  @override
  List<Object> get props => [recommendationMovie];
}

class GetRecommendationMovieFailedState extends MovieDetailsState {
  final String message;

  const GetRecommendationMovieFailedState(this.message);

  @override
  List<Object> get props => [message];
}
