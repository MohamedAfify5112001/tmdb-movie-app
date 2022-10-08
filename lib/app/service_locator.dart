import 'package:clean_architature_movie_app/app/controller/home_layout_bloc.dart';
import 'package:clean_architature_movie_app/movies/data/datasource/movie_remote_datasource.dart';
import 'package:clean_architature_movie_app/movies/data/repository/movie_repo_imp.dart';
import 'package:clean_architature_movie_app/movies/domain/repository/base_movie_repository.dart';
import 'package:clean_architature_movie_app/movies/domain/usecases/get_moive_deatils_usecase.dart';
import 'package:clean_architature_movie_app/movies/domain/usecases/get_now_playing_usecase.dart';
import 'package:clean_architature_movie_app/movies/domain/usecases/get_popular_movie_usecase.dart';
import 'package:clean_architature_movie_app/movies/domain/usecases/get_recommendation_movies_usecase.dart';
import 'package:clean_architature_movie_app/movies/domain/usecases/get_top_rated_movie_usecase.dart';
import 'package:clean_architature_movie_app/movies/presentation/controllers/movie_bloc.dart';
import 'package:clean_architature_movie_app/movies/presentation/controllers/movie_details_bloc.dart';
import 'package:clean_architature_movie_app/tvs/data/datasource/tv_remote_datasource.dart';
import 'package:clean_architature_movie_app/tvs/data/repository/tv_repo_imp.dart';
import 'package:clean_architature_movie_app/tvs/domain/repository/base_tvs_repo.dart';
import 'package:clean_architature_movie_app/tvs/domain/usecases/get_on_air_tvs_usecase.dart';
import 'package:clean_architature_movie_app/tvs/domain/usecases/get_popular_tv_usecase.dart';
import 'package:clean_architature_movie_app/tvs/domain/usecases/get_top_rated_usecase.dart';
import 'package:clean_architature_movie_app/tvs/presentation/controllers/tv_bloc.dart';
import 'package:clean_architature_movie_app/tvs/presentation/controllers/tvdetails_bloc.dart';
import 'package:get_it/get_it.dart';

import '../tvs/domain/usecases/get_recommendation_tvs_usecase.dart';
import '../tvs/domain/usecases/get_season_epoisodes_usecase.dart';
import '../tvs/domain/usecases/get_tv_details_usecase.dart';

final instanceServiceLocator = GetIt.instance;

Future<void> initMoviesModule() async {
  // Movies
  instanceServiceLocator.registerLazySingleton<BaseMovieRemoteDataSource>(
      () => MovieRemoteDataSource());
  instanceServiceLocator.registerLazySingleton<BaseMovieRepository>(
      () => MovieRepository(instanceServiceLocator()));

  instanceServiceLocator.registerLazySingleton<GetPopularMovieUseCase>(
      () => GetPopularMovieUseCase(instanceServiceLocator()));

  instanceServiceLocator.registerLazySingleton<GetNowPlayingMovieUseCase>(
      () => GetNowPlayingMovieUseCase(instanceServiceLocator()));

  instanceServiceLocator.registerLazySingleton(
      () => GetTopRatedMovieUseCase(instanceServiceLocator()));
  instanceServiceLocator.registerFactory(() => MovieBloc(
      instanceServiceLocator<GetPopularMovieUseCase>(),
      instanceServiceLocator<GetNowPlayingMovieUseCase>(),
      instanceServiceLocator<GetTopRatedMovieUseCase>()));
  instanceServiceLocator.registerLazySingleton<GetMovieDetailsUseCase>(
      () => GetMovieDetailsUseCase(instanceServiceLocator()));
  instanceServiceLocator.registerLazySingleton<GetRecommendationMovieUseCase>(
      () => GetRecommendationMovieUseCase(instanceServiceLocator()));
  instanceServiceLocator.registerFactory(() =>
      MovieDetailsBloc(instanceServiceLocator(), instanceServiceLocator()));
  instanceServiceLocator.registerFactory(() => HomeLayoutBloc());
}

Future<void> initTVSModule() async {
  instanceServiceLocator.registerLazySingleton<BaseTVRemoteDataSource>(
      () => TvRemoteDataSource());
  instanceServiceLocator.registerLazySingleton<BaseTVSRepository>(
      () => TVRepository(instanceServiceLocator()));
  instanceServiceLocator.registerLazySingleton<GetOnAirTvsUseCase>(
      () => GetOnAirTvsUseCase(instanceServiceLocator()));
  instanceServiceLocator.registerLazySingleton<GetPopularTVUseCase>(
      () => GetPopularTVUseCase(instanceServiceLocator()));
  instanceServiceLocator.registerLazySingleton<GetTvTopRatedUseCase>(
      () => GetTvTopRatedUseCase(instanceServiceLocator()));
  instanceServiceLocator.registerLazySingleton<GetTVDetailsUseCase>(
      () => GetTVDetailsUseCase(instanceServiceLocator()));
  instanceServiceLocator.registerLazySingleton<GetRecommendationTVSUseCase>(
      () => GetRecommendationTVSUseCase(instanceServiceLocator()));
  instanceServiceLocator.registerLazySingleton<GetSeasonTVUseCase>(
      () => GetSeasonTVUseCase(instanceServiceLocator()));
  instanceServiceLocator.registerFactory<TvBloc>(() => TvBloc(
        instanceServiceLocator<GetOnAirTvsUseCase>(),
        instanceServiceLocator<GetPopularTVUseCase>(),
        instanceServiceLocator<GetTvTopRatedUseCase>(),
      ));
  instanceServiceLocator.registerFactory<TVDetailsBloc>(() => TVDetailsBloc(
      instanceServiceLocator<GetTVDetailsUseCase>(),
      instanceServiceLocator<GetRecommendationTVSUseCase>(),
      instanceServiceLocator<GetSeasonTVUseCase>()));
}
