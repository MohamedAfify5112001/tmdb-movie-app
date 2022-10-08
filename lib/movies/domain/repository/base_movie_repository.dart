import 'package:clean_architature_movie_app/movies/domain/entities/movie.dart';
import 'package:clean_architature_movie_app/movies/domain/usecases/get_recommendation_movies_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../core/exceptions/failure.dart';
import '../entities/movie_details.dart';
import '../entities/recommendation_movies.dart';
import '../usecases/get_moive_deatils_usecase.dart';

abstract class BaseMovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovie();

  Future<Either<Failure, List<Movie>>> getPopularMovie();

  Future<Either<Failure, List<Movie>>> getTopRatedMovie();

  Future<Either<Failure, MovieDetails>> getMovieDetails(
      MovieDetailsParam movieParam);

  Future<Either<Failure, List<RecommendationMovie>>> getRecommendationMovies(
      RecommendationMovieParam param);
}
