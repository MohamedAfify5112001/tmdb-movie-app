import 'package:clean_architature_movie_app/core/exceptions/failure.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/no_param_tv.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/tvs.dart';
import 'package:clean_architature_movie_app/tvs/domain/repository/base_tvs_repo.dart';
import 'package:clean_architature_movie_app/tvs/domain/usecases/base_tv_usecase.dart';
import 'package:dartz/dartz.dart';

class GetPopularTVUseCase implements BaseTVUseCase<NoParameters, List<TV>> {
  final BaseTVSRepository tvsRepository;

  GetPopularTVUseCase(this.tvsRepository);

  @override
  Future<Either<Failure, List<TV>>> call(NoParameters param) async {
    return await tvsRepository.getPopularTvs();
  }
}
