import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../core/exceptions/failure.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/recommendation_movies.dart';
import '../../domain/usecases/get_moive_deatils_usecase.dart';
import '../../domain/usecases/get_recommendation_movies_usecase.dart';

part 'movie_details_event.dart';

part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetRecommendationMovieUseCase getRecommendationMoviesUseCase;

  MovieDetailsBloc(
      this.getMovieDetailsUseCase, this.getRecommendationMoviesUseCase)
      : super(MovieDetailsInitial()) {
    on<GetMovieDetailsEvent>((event, emit) async {
      emit(GetMovieDetailsLoadingState());
      final Either<Failure, MovieDetails> result =
          await getMovieDetailsUseCase(MovieDetailsParam(event.movieId));
      result.fold((fail) => emit(GetMovieDetailsFailedState(fail.msg)),
          (movieDetails) {
        emit(GetMovieDetailsLoadedState(movieDetails));
      });
    });
    on<GetRecommendationMoviesEvent>((event, emit) async {
      emit(GetRecommendationMovieLoadingState());
      final Either<Failure, List<RecommendationMovie>> result =
          await getRecommendationMoviesUseCase(
              RecommendationMovieParam(event.movieId));
      result.fold(
          (fail) => emit(GetRecommendationMovieFailedState(fail.msg)),
          (recommendationMovie) =>
              emit(GetRecommendationMovieLoadedState(recommendationMovie)));
    });
  }
}
