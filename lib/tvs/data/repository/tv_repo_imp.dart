import 'package:clean_architature_movie_app/core/exceptions/exceptions.dart';
import 'package:clean_architature_movie_app/core/exceptions/failure.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/base_tv_details_param.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/recommendation_tvs.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/season.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/tv_details.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/tvs.dart';
import 'package:clean_architature_movie_app/tvs/domain/repository/base_tvs_repo.dart';
import 'package:dartz/dartz.dart';

import '../datasource/tv_remote_datasource.dart';

class TVRepository implements BaseTVSRepository {
  final BaseTVRemoteDataSource tvRemoteDataSource;

  TVRepository(this.tvRemoteDataSource);

  @override
  Future<Either<Failure, List<TV>>> getOnAirTvs() async {
    try {
      final List<TV> tvOnAirList = await tvRemoteDataSource.getOnAirTvs();
      return Right(tvOnAirList);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getPopularTvs() async {
    try {
      final List<TV> tvPopularList = await tvRemoteDataSource.getPopularTvs();
      return Right(tvPopularList);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getTopRatedTvs() async {
    try {
      final List<TV> tvTopRatedList = await tvRemoteDataSource.getTopRatedTvs();
      return Right(tvTopRatedList);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, TVDetails>> getAllDetailsForTV(
      TVAllDetailsParameter param) async {
    try {
      final TVDetails tvDetails =
          await tvRemoteDataSource.getAllDetailsForTV(param);
      return Right(tvDetails);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<RecommendationTVS>>> getAllRecommendationForTV(
      TVRecommendationParameter param) async {
    try {
      final List<RecommendationTVS> recommendationTVS =
          await tvRemoteDataSource.getAllRecommendationForTV(param);
      return Right(recommendationTVS);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Season>>> getSeasonForTV(
      TVSeasonsParameter param) async {
    try {
      final List<Season> seasonList =
          await tvRemoteDataSource.getSeasonForTV(param);
      return Right(seasonList);
    } on ServerException catch (error) {
      return Left(ServerFailure(msg: error.errorMessageModel.statusMessage));
    }
  }
}
