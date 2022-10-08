import 'package:clean_architature_movie_app/core/exceptions/exceptions.dart';
import 'package:clean_architature_movie_app/core/network/dio/dio_helper.dart';
import 'package:clean_architature_movie_app/core/network/error_message_model.dart';
import 'package:clean_architature_movie_app/core/utils/app_constants.dart';
import 'package:clean_architature_movie_app/tvs/data/models/recommendation_tv_model.dart';
import 'package:clean_architature_movie_app/tvs/data/models/season_model.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/base_tv_details_param.dart';
import '../models/tv_details_model.dart';
import '../models/tvs_model.dart';

abstract class BaseTVRemoteDataSource {
  Future<List<TVModel>> getOnAirTvs();

  Future<List<TVModel>> getPopularTvs();

  Future<List<TVModel>> getTopRatedTvs();

  Future<TVDetailsModel> getAllDetailsForTV(TVAllDetailsParameter param);

  Future<List<RecommendationTVModel>> getAllRecommendationForTV(
      TVRecommendationParameter param);

  Future<List<SeasonModel>> getSeasonForTV(TVSeasonsParameter param);
}

class TvRemoteDataSource implements BaseTVRemoteDataSource {
  @override
  Future<List<TVModel>> getOnAirTvs() async {
    final Response response =
        await DioHelper.getData(path: AppConstants.pathOnAirTv);
    if (response.statusCode == 200) {
      final castResponse = response.data['results'] as List;
      final List<TVModel> onAirTvList =
          castResponse.map((onAir) => TVModel.fromJson(onAir)).toList();
      return onAirTvList;
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<TVModel>> getPopularTvs() async {
    final Response response =
        await DioHelper.getData(path: AppConstants.pathPopularTv);
    if (response.statusCode == 200) {
      final castResponse = response.data['results'] as List;
      final List<TVModel> popularTvList =
          castResponse.map((popularTV) => TVModel.fromJson(popularTV)).toList();
      return popularTvList;
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<TVModel>> getTopRatedTvs() async {
    final Response response =
        await DioHelper.getData(path: AppConstants.pathTopRatedTv);
    if (response.statusCode == 200) {
      final castResponse = response.data['results'] as List;
      final List<TVModel> topRatedTvList = castResponse
          .map((topRatedTv) => TVModel.fromJson(topRatedTv))
          .toList();
      return topRatedTvList;
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<TVDetailsModel> getAllDetailsForTV(TVAllDetailsParameter param) async {
    final Response response = await DioHelper.getData(
        path: AppConstants.parseTVDetailsPath(param.id));
    if (response.statusCode == 200) {
      final castResponse = response.data;
      final TVDetailsModel tvDetailsModel =
          TVDetailsModel.fromJson(castResponse);
      return tvDetailsModel;
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<RecommendationTVModel>> getAllRecommendationForTV(
      TVRecommendationParameter param) async {
    final Response response = await DioHelper.getData(
        path: AppConstants.parseTVRecommendationPath(param.id));
    if (response.statusCode == 200) {
      final castResponse = response.data['results'] as List;
      final List<RecommendationTVModel> recommendations = castResponse
          .map((recommendation) =>
              RecommendationTVModel.fromJson(recommendation))
          .toList();
      return recommendations;
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<SeasonModel>> getSeasonForTV(TVSeasonsParameter param) async {
    List<SeasonModel> seasonList = [];
    final Response response = await DioHelper.getData(
        path: AppConstants.parseTVSeasonPath(
            param.id, ((param.seasonNumber > 1) ? 1 : 1)));
    if (response.statusCode == 200) {
      final SeasonModel seasonModel = SeasonModel.fromJson(response.data);
      seasonList.add(seasonModel);
      return seasonList;
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }
}
