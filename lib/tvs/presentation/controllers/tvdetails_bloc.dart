import 'dart:async';

import 'package:clean_architature_movie_app/core/exceptions/failure.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/base_tv_details_param.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/season.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/tv_details.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/recommendation_tvs.dart';
import '../../domain/usecases/get_recommendation_tvs_usecase.dart';
import '../../domain/usecases/get_season_epoisodes_usecase.dart';
import '../../domain/usecases/get_tv_details_usecase.dart';

part 'tvdetails_event.dart';

part 'tvdetails_state.dart';

class TVDetailsBloc extends Bloc<TVDetailsEvent, TVDetailsState> {
  final GetTVDetailsUseCase getTVDetailsUseCase;
  final GetRecommendationTVSUseCase getRecommendationTVSUseCase;
  final GetSeasonTVUseCase getSeasonTVUseCase;
  TVDetails? tvDetails;
  List<RecommendationTVS> recommendationTVSList = [];
  List<Season> seasonTVList = [];

  TVDetailsBloc(this.getTVDetailsUseCase, this.getRecommendationTVSUseCase,
      this.getSeasonTVUseCase)
      : super(const TVDetailsInitial()) {
    on<GetTVDetailsEvent>((event, emit) async {
      emit(const GetTVDetailsLoadingState());
      final Either<Failure, TVDetails> result =
          await getTVDetailsUseCase(TVAllDetailsParameter(event.id));
      result.fold((fail) => emit(GetTVDetailsFailureState(fail.msg)),
          (detailsTV) {
        tvDetails = detailsTV;
        emit(const GetTVDetailsLoadedState());
      });
    });

    on<GetTVRecommendationEvent>((event, emit) async {
      emit(const GetRecommendationTVLoadingState());
      final Either<Failure, List<RecommendationTVS>> result =
          await getRecommendationTVSUseCase(
              TVRecommendationParameter(event.id));
      result.fold((fail) => emit(GetRecommendationTVFailureState(fail.msg)),
          (recommendationTVS) {
        recommendationTVSList = recommendationTVS;
        emit(const GetRecommendationTVLoadedState());
      });
    });

    on<GetTVSeasonEvent>((event, emit) async {
      emit(const GetSeasonTVLoadingState());
      final Either<Failure, List<Season>> result = await getSeasonTVUseCase(
          TVSeasonsParameter(event.id, event.seasonNumber));
      result.fold((fail) => emit(GetSeasonTVFailureState(fail.msg)),
          (seasonTVS) {
        seasonTVList = seasonTVS;
        emit(const GetSeasonTVLoadedState());
      });
    });
  }
}
