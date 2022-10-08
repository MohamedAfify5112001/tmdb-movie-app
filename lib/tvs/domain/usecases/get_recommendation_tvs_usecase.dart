import 'package:clean_architature_movie_app/core/exceptions/failure.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/recommendation_tvs.dart';
import 'package:clean_architature_movie_app/tvs/domain/repository/base_tvs_repo.dart';
import 'package:clean_architature_movie_app/tvs/domain/usecases/base_tv_usecase.dart';
import 'package:dartz/dartz.dart';

import '../entities/base_tv_details_param.dart';

class GetRecommendationTVSUseCase
    implements
        BaseTVUseCase<TVRecommendationParameter, List<RecommendationTVS>> {
  final BaseTVSRepository tvsRepository;

  GetRecommendationTVSUseCase(this.tvsRepository);

  @override
  Future<Either<Failure, List<RecommendationTVS>>> call(
      TVRecommendationParameter param) async {
    return await tvsRepository.getAllRecommendationForTV(param);
  }
}
