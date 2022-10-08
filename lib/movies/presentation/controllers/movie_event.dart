part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class GetPopularMovieEvent extends MovieEvent {
  const GetPopularMovieEvent();

  @override
  List<Object> get props => [];
}

class GetTopRatedMovieEvent extends MovieEvent {
  const GetTopRatedMovieEvent();

  @override
  List<Object> get props => [];
}

class GetNowPlayingMovieEvent extends MovieEvent {
  const GetNowPlayingMovieEvent();

  @override
  List<Object> get props => [];
}
