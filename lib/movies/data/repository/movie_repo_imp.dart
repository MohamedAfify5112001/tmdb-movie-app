import 'package:clean_architature_movie_app/core/exceptions/exceptions.dart';
import 'package:clean_architature_movie_app/core/exceptions/failure.dart';
import 'package:clean_architature_movie_app/movies/data/datasource/movie_remote_datasource.dart';
import 'package:clean_architature_movie_app/movies/domain/entities/movie.dart';
import 'package:clean_architature_movie_app/movies/domain/entities/movie_details.dart';
import 'package:clean_architature_movie_app/movies/domain/entities/recommendation_movies.dart';
import 'package:clean_architature_movie_app/movies/domain/repository/base_movie_repository.dart';
import 'package:clean_architature_movie_app/movies/domain/usecases/get_recommendation_movies_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../domain/usecases/get_moive_deatils_usecase.dart';

class MovieRepository implements BaseMovieRepository {
  final BaseMovieRemoteDataSource remoteDataSource;

  MovieRepository(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovie() async {
    try {
      final List<Movie> nowPlayingMovie =
          await remoteDataSource.getNowPlayingMovie();
      return Right(nowPlayingMovie);
    } on ServerException catch (failure) {
      return Left(ServerFailure(msg: failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovie() async {
    try {
      final List<Movie> popularMovie = await remoteDataSource.getPopularMovie();
      return Right(popularMovie);
    } on ServerException catch (failure) {
      return Left(ServerFailure(msg: failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovie() async {
    try {
      final List<Movie> topRatedMovie =
          await remoteDataSource.getTopRatedMovie();
      return Right(topRatedMovie);
    } on ServerException catch (failure) {
      return Left(ServerFailure(msg: failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(
      MovieDetailsParam movieParam) async {
    try {
      final MovieDetails movieDetails =
          await remoteDataSource.getMovieDetails(movieParam);
      return Right(movieDetails);
    } on ServerException catch (error) {
      final ServerFailure serverFailure =
          ServerFailure(msg: error.errorMessageModel.statusMessage);
      return Left(serverFailure);
    }
  }

  @override
  Future<Either<Failure, List<RecommendationMovie>>> getRecommendationMovies(
      RecommendationMovieParam param) async {
    try {
      final List<RecommendationMovie> recommendationMovies =
          await remoteDataSource.getRecommendationMovies(param);
      return Right(recommendationMovies);
    } on ServerException catch (error) {
      final ServerFailure serverFailure =
          ServerFailure(msg: error.errorMessageModel.statusMessage);
      return Left(serverFailure);
    }
  }
}
