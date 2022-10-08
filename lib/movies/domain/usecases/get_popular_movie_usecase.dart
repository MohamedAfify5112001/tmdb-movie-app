import 'package:dartz/dartz.dart';
import '../../../core/exceptions/failure.dart';
import '../entities/movie.dart';
import '../entities/no_param.dart';
import '../repository/base_movie_repository.dart';
import 'base_movie_usecase.dart';

class GetPopularMovieUseCase implements BaseMovieUseCase<NoParam, List<Movie>> {
  final BaseMovieRepository baseMovieRepository;

  GetPopularMovieUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParam param) async {
    return await baseMovieRepository.getPopularMovie();
  }
}
