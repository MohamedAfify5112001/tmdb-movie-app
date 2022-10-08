import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architature_movie_app/core/exceptions/failure.dart';
import 'package:clean_architature_movie_app/movies/domain/usecases/get_now_playing_usecase.dart';
import 'package:clean_architature_movie_app/movies/domain/usecases/get_top_rated_movie_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/no_param.dart';
import '../../domain/usecases/get_popular_movie_usecase.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovieUseCase getPopularMovieUseCase;
  final GetNowPlayingMovieUseCase getNowPlayingMovieUseCase;
  final GetTopRatedMovieUseCase getTopRatedMovieUseCase;
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];

  MovieBloc(this.getPopularMovieUseCase, this.getNowPlayingMovieUseCase,
      this.getTopRatedMovieUseCase)
      : super(MovieInitial()) {
    on<GetPopularMovieEvent>((event, emit) async {
      emit(GetPopularMovieLoadingState());
      final Either<Failure, List<Movie>> result =
          await getPopularMovieUseCase(const NoParam());
      result.fold((fail) {
        emit(GetPopularMovieFailedState(fail.msg));
      }, (popularMovie) {
        popularMovies = popularMovie;
        emit(GetPopularMovieLoadedState(popularMovie));
      });
    });

    on<GetNowPlayingMovieEvent>((event, emit) async {
      emit(GetNowPlayingLoadingState());
      final Either<Failure, List<Movie>> result =
          await getNowPlayingMovieUseCase(const NoParam());
      result.fold((fail) {
        emit(GetNowPlayingFailedState(fail.msg));
      }, (nowPlayingMovie) {
        emit(GetNowPlayingLoadedState(nowPlayingMovie));
      });
    });

    on<GetTopRatedMovieEvent>((event, emit) async {
      emit(GetTopRatedLoadingState());
      final Either<Failure, List<Movie>> result =
          await getTopRatedMovieUseCase(const NoParam());
      result.fold((fail) {
        emit(GetTopRatedFailedState(fail.msg));
      }, (topRatedMovie) {
        topRatedMovies = topRatedMovie;
        emit(GetTopRatedLoadedState(topRatedMovies));
      });
    });
  }
}
