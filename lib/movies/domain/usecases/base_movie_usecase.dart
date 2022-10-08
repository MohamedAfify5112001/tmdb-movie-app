import 'package:clean_architature_movie_app/core/exceptions/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseMovieUseCase<In, Out> {
  Future<Either<Failure, Out>> call(In param);
}
