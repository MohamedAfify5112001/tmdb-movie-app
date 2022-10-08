import 'package:clean_architature_movie_app/core/exceptions/failure.dart';
import 'package:clean_architature_movie_app/movies/domain/entities/movie_param.dart';
import 'package:clean_architature_movie_app/movies/domain/entities/recommendation_movies.dart';
import 'package:clean_architature_movie_app/movies/domain/repository/base_movie_repository.dart';
import 'package:clean_architature_movie_app/movies/domain/usecases/base_movie_usecase.dart';
import 'package:dartz/dartz.dart';

class GetRecommendationMovieUseCase
    implements
        BaseMovieUseCase<RecommendationMovieParam, List<RecommendationMovie>> {
  final BaseMovieRepository movieRepository;

  GetRecommendationMovieUseCase(this.movieRepository);

  @override
  Future<Either<Failure, List<RecommendationMovie>>> call(
      RecommendationMovieParam param) async {
    return await movieRepository.getRecommendationMovies(param);
  }
}

class RecommendationMovieParam extends MovieParam {
  const RecommendationMovieParam(super.movieId);
}
