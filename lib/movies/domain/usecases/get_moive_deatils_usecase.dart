import 'package:clean_architature_movie_app/core/exceptions/failure.dart';
import 'package:clean_architature_movie_app/movies/domain/entities/movie_details.dart';
import 'package:clean_architature_movie_app/movies/domain/entities/movie_param.dart';
import 'package:clean_architature_movie_app/movies/domain/repository/base_movie_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'base_movie_usecase.dart';

class GetMovieDetailsUseCase
    implements BaseMovieUseCase<MovieDetailsParam, MovieDetails> {
  final BaseMovieRepository movieRepository;

  GetMovieDetailsUseCase(this.movieRepository);

  @override
  Future<Either<Failure, MovieDetails>> call(
      MovieDetailsParam movieParam) async {
    return await movieRepository.getMovieDetails(movieParam);
  }
}

class MovieDetailsParam extends MovieParam {
  const MovieDetailsParam(super.movieId);

  @override
  List<Object> get props => [movieId];
}
