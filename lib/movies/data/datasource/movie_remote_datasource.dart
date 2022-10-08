import 'package:clean_architature_movie_app/core/exceptions/exceptions.dart';
import 'package:clean_architature_movie_app/core/network/dio/dio_helper.dart';
import 'package:clean_architature_movie_app/core/utils/app_constants.dart';
import 'package:clean_architature_movie_app/movies/data/models/movie_details_model.dart';
import 'package:clean_architature_movie_app/movies/data/models/movie_model.dart';
import 'package:clean_architature_movie_app/movies/data/models/recommendation_movie_model.dart';
import 'package:clean_architature_movie_app/movies/domain/usecases/get_recommendation_movies_usecase.dart';
import 'package:dio/dio.dart';

import '../../../core/network/error_message_model.dart';
import '../../domain/usecases/get_moive_deatils_usecase.dart';

abstract class BaseMovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovie();

  Future<List<MovieModel>> getNowPlayingMovie();

  Future<List<MovieModel>> getTopRatedMovie();

  Future<MovieDetailsModel> getMovieDetails(MovieDetailsParam movieParam);

  Future<List<RecommendationMovieModel>> getRecommendationMovies(
      RecommendationMovieParam recommendationMovieParam);
}

class MovieRemoteDataSource implements BaseMovieRemoteDataSource {
  @override
  Future<List<MovieModel>> getPopularMovie() async {
    final Response response =
        await DioHelper.getData(path: AppConstants.pathPopularMovie);

    if (response.statusCode == 200) {
      final responseData = response.data['results'] as List;
      List<MovieModel> movieListData = List<MovieModel>.from(
          responseData.map((movie) => MovieModel.formJson(movie)));
      return movieListData;
    } else {
      throw (ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data)));
    }
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovie() async {
    final Response response =
        await DioHelper.getData(path: AppConstants.pathNowPlayingMovie);

    if (response.statusCode == 200) {
      final responseData = response.data['results'] as List;
      List<MovieModel> movieListData = List<MovieModel>.from(
          responseData.map((movie) => MovieModel.formJson(movie)));
      return movieListData;
    } else {
      throw (ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data)));
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovie() async {
    final Response response =
        await DioHelper.getData(path: AppConstants.pathTopRatedMovie);

    if (response.statusCode == 200) {
      final responseData = response.data['results'] as List;
      List<MovieModel> movieListData = List<MovieModel>.from(
          responseData.map((movie) => MovieModel.formJson(movie)));
      return movieListData;
    } else {
      throw (ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data)));
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(
      MovieDetailsParam movieParam) async {
    final Response response = await DioHelper.getData(
        path: AppConstants.parseMovieDetailsPath(movieParam.movieId));
    if (response.statusCode == 200) {
      final MovieDetailsModel movieDetails =
          MovieDetailsModel.fromJson(response.data);
      return movieDetails;
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<RecommendationMovieModel>> getRecommendationMovies(
      RecommendationMovieParam recommendationMovieParam) async {
    final Response response = await DioHelper.getData(
        path: AppConstants.parseMovieRecommendationPath(
            recommendationMovieParam.movieId));
    if (response.statusCode == 200) {
      List res = (response.data['results']) as List;
      final List<RecommendationMovieModel> recommendationMovie =
          List<RecommendationMovieModel>.from(res.map((recommendationMovie) =>
              RecommendationMovieModel.fromJson(recommendationMovie)));
      return recommendationMovie;
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }
}
