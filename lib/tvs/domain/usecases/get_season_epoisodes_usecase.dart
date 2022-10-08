import 'package:clean_architature_movie_app/core/exceptions/failure.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/season.dart';
import 'package:clean_architature_movie_app/tvs/domain/repository/base_tvs_repo.dart';
import 'package:clean_architature_movie_app/tvs/domain/usecases/base_tv_usecase.dart';
import 'package:dartz/dartz.dart';

import '../entities/base_tv_details_param.dart';

class GetSeasonTVUseCase implements BaseTVUseCase<TVSeasonsParameter, List<Season>> {
  final BaseTVSRepository tvsRepository;

  GetSeasonTVUseCase(this.tvsRepository);

  @override
  Future<Either<Failure, List<Season>>> call(TVSeasonsParameter param) async {
    return await tvsRepository.getSeasonForTV(param);
  }
}
