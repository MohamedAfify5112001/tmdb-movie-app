part of 'movie_bloc.dart';

@immutable
abstract class MovieState {}

class MovieInitial extends MovieState {}

class GetPopularMovieLoadingState extends MovieState {}

class GetPopularMovieLoadedState extends MovieState {
  final List<Movie> popularMovie;

  GetPopularMovieLoadedState(this.popularMovie);

  GetPopularMovieLoadedState copyWith({List<Movie>? popularMovie}) {
    return GetPopularMovieLoadedState(popularMovie ?? this.popularMovie);
  }
}

class GetPopularMovieFailedState extends MovieState {
  final String message;

  GetPopularMovieFailedState(this.message);

  GetPopularMovieFailedState copyWith({String? message}) {
    return GetPopularMovieFailedState(message ?? this.message);
  }
}

class GetNowPlayingLoadingState extends MovieState {}

class GetNowPlayingLoadedState extends MovieState {
  final List<Movie> nowPlayingMovie;

  GetNowPlayingLoadedState(this.nowPlayingMovie);

  GetNowPlayingLoadedState copyWith({List<Movie>? nowPlayingMovie}) {
    return GetNowPlayingLoadedState(nowPlayingMovie ?? this.nowPlayingMovie);
  }
}

class GetNowPlayingFailedState extends MovieState {
  final String message;

  GetNowPlayingFailedState(this.message);

  GetNowPlayingFailedState copyWith({String? message}) {
    return GetNowPlayingFailedState(message ?? this.message);
  }
}

class GetTopRatedLoadingState extends MovieState {}

class GetTopRatedLoadedState extends MovieState {
  final List<Movie> topRatedMovies;

  GetTopRatedLoadedState(this.topRatedMovies);

  GetTopRatedLoadedState copyWith({List<Movie>? topRatedMovies}) {
    return GetTopRatedLoadedState(topRatedMovies ?? this.topRatedMovies);
  }
}

class GetTopRatedFailedState extends MovieState {
  final String message;

  GetTopRatedFailedState(this.message);

  GetTopRatedFailedState copyWith({String? message}) {
    return GetTopRatedFailedState(message ?? this.message);
  }
}

