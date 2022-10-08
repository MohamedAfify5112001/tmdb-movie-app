import 'package:clean_architature_movie_app/tvs/domain/entities/no_param_tv.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/tv_details.dart';
import 'package:dartz/dartz.dart';

import '../../../core/exceptions/failure.dart';
import '../entities/base_tv_details_param.dart';
import '../entities/recommendation_tvs.dart';
import '../entities/season.dart';
import '../entities/tvs.dart';

abstract class BaseTVSRepository {
  Future<Either<Failure, List<TV>>> getOnAirTvs();

  Future<Either<Failure, List<TV>>> getPopularTvs();

  Future<Either<Failure, List<TV>>> getTopRatedTvs();

  Future<Either<Failure, TVDetails>> getAllDetailsForTV(
      TVAllDetailsParameter param);

  Future<Either<Failure, List<RecommendationTVS>>> getAllRecommendationForTV(
      TVRecommendationParameter param);

  Future<Either<Failure, List<Season>>> getSeasonForTV(TVSeasonsParameter param);
}
