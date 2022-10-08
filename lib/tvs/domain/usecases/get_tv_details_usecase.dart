import 'package:clean_architature_movie_app/core/exceptions/failure.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/tv_details.dart';
import 'package:clean_architature_movie_app/tvs/domain/repository/base_tvs_repo.dart';
import 'package:clean_architature_movie_app/tvs/domain/usecases/base_tv_usecase.dart';
import 'package:dartz/dartz.dart';

import '../entities/base_tv_details_param.dart';

class GetTVDetailsUseCase
    implements BaseTVUseCase<TVAllDetailsParameter, TVDetails> {
  final BaseTVSRepository tvsRepository;

  GetTVDetailsUseCase(this.tvsRepository);

  @override
  Future<Either<Failure, TVDetails>> call(TVAllDetailsParameter param) async {
    return await tvsRepository.getAllDetailsForTV(param);
  }
}
