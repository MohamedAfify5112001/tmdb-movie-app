import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architature_movie_app/core/exceptions/failure.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/no_param_tv.dart';
import 'package:clean_architature_movie_app/tvs/domain/usecases/get_popular_tv_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/tvs.dart';
import '../../domain/usecases/get_on_air_tvs_usecase.dart';
import '../../domain/usecases/get_top_rated_usecase.dart';

part 'tv_event.dart';

part 'tv_state.dart';

class TvBloc extends Bloc<TvEvent, TvState> {
  final GetOnAirTvsUseCase getOnAirTvsUseCase;
  final GetPopularTVUseCase getPopularTVUseCase;
  final GetTvTopRatedUseCase getTvTopRatedUseCase;
  List<TV> onAirTvData = [];
  List<TV> popularTvData = [];
  List<TV> topRatedTvData = [];

  TvBloc(this.getOnAirTvsUseCase, this.getPopularTVUseCase,
      this.getTvTopRatedUseCase)
      : super(const TvInitial()) {
    on<GetOnAirTVEvent>((event, emit) async {
      emit(const GetOnAirLoadingState());
      final Either<Failure, List<TV>> result =
          await getOnAirTvsUseCase(const NoParameters());
      result.fold((fail) => emit(GetOnAirFailedState(fail.msg)), (onAir) {
        if (onAir.isNotEmpty) {
          onAirTvData = onAir;
          onAirTvData
              .removeWhere((item) => item.originalName == "Euronews Hoy");
          onAirTvData
              .removeWhere((item) => item.originalName == "Poliana Moça");
          onAirTvData.removeWhere((item) => item.originalName == "Lisa");
          emit(const GetOnAirLoadedState());
        }
      });
    });

    on<GetPopularTVEvent>((event, emit) async {
      emit(const GetPopularTvLoadingState());
      final Either<Failure, List<TV>> result =
          await getPopularTVUseCase(const NoParameters());
      result.fold((fail) => emit(GetPopularTvFailedState(fail.msg)),
          (popularTvData) {
        if (popularTvData.isNotEmpty) {
          this.popularTvData = popularTvData;
          this
              .popularTvData
              .removeWhere((item) => item.originalName == "Euronews Hoy");
          this
              .popularTvData
              .removeWhere((item) => item.originalName == "Poliana Moça");
          this.popularTvData.removeWhere((item) => item.originalName == "Lisa");
          emit(const GetPopularTvLoadedState());
        }
      });
    });

    on<GetTopRatedTVEvent>((event, emit) async {
      emit(const GetTopRatedTvLoadingState());
      final Either<Failure, List<TV>> result =
          await getTvTopRatedUseCase(const NoParameters());
      result.fold((fail) => emit(GetTopRatedTvFailedState(fail.msg)),
          (topRatedTvData) {
        if (topRatedTvData.isNotEmpty) {
          this.topRatedTvData = topRatedTvData
              .where((element) =>
                  (element.originalName != "Desafío Champions Sendokai"))
              .toList();
          emit(const GetTopRatedTvLoadedState());
        }
      });
    });
  }
}
