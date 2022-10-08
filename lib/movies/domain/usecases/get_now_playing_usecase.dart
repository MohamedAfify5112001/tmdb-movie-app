import 'package:clean_architature_movie_app/movies/domain/repository/base_movie_repository.dart';
import 'package:clean_architature_movie_app/movies/domain/usecases/base_movie_usecase.dart';
import 'package:dartz/dartz.dart';
import '../entities/no_param.dart';

import '../../../core/exceptions/failure.dart';
import '../entities/movie.dart';

class GetNowPlayingMovieUseCase
    implements BaseMovieUseCase<NoParam, List<Movie>> {
  final BaseMovieRepository baseMovieRepository;

  GetNowPlayingMovieUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParam param) async {
    return await baseMovieRepository.getNowPlayingMovie();
  }
}

