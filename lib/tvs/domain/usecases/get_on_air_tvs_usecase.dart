import 'package:clean_architature_movie_app/core/exceptions/failure.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/no_param_tv.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/tvs.dart';
import 'package:clean_architature_movie_app/tvs/domain/usecases/base_tv_usecase.dart';
import 'package:dartz/dartz.dart';

import '../repository/base_tvs_repo.dart';

class GetOnAirTvsUseCase implements BaseTVUseCase<NoParameters, List<TV>> {
  final BaseTVSRepository tvSRepository;

  GetOnAirTvsUseCase(this.tvSRepository);

  @override
  Future<Either<Failure, List<TV>>> call(NoParameters noParameters) async {
    return await tvSRepository.getOnAirTvs();
  }
}
