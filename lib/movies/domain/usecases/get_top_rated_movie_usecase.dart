import 'package:clean_architature_movie_app/core/exceptions/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/no_param.dart';

import '../entities/movie.dart';
import '../repository/base_movie_repository.dart';
import 'base_movie_usecase.dart';

class GetTopRatedMovieUseCase
    implements BaseMovieUseCase<NoParam, List<Movie>> {
  final BaseMovieRepository baseMovieRepository;

  GetTopRatedMovieUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParam param) async {
    return await baseMovieRepository.getTopRatedMovie();
  }
}
