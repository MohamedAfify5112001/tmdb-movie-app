part of 'tvdetails_bloc.dart';

abstract class TVDetailsState extends Equatable {
  const TVDetailsState();
}

class TVDetailsInitial extends TVDetailsState {
  const TVDetailsInitial();

  @override
  List<Object> get props => [];
}

class GetTVDetailsLoadedState extends TVDetailsState {
  const GetTVDetailsLoadedState();

  @override
  List<Object> get props => [];
}

class GetTVDetailsLoadingState extends TVDetailsState {
  const GetTVDetailsLoadingState();

  @override
  List<Object> get props => [];
}

class GetTVDetailsFailureState extends TVDetailsState {
  final String msg;

  const GetTVDetailsFailureState(this.msg);

  @override
  List<Object> get props => [msg];
}

class GetRecommendationTVLoadedState extends TVDetailsState {
  const GetRecommendationTVLoadedState();

  @override
  List<Object> get props => [];
}

class GetRecommendationTVLoadingState extends TVDetailsState {
  const GetRecommendationTVLoadingState();

  @override
  List<Object> get props => [];
}

class GetRecommendationTVFailureState extends TVDetailsState {
  final String msg;

  const GetRecommendationTVFailureState(this.msg);

  @override
  List<Object> get props => [msg];
}

class GetSeasonTVLoadedState extends TVDetailsState {
  const GetSeasonTVLoadedState();

  @override
  List<Object> get props => [];
}

class GetSeasonTVLoadingState extends TVDetailsState {
  const GetSeasonTVLoadingState();

  @override
  List<Object> get props => [];
}

class GetSeasonTVFailureState extends TVDetailsState {
  final String msg;

  const GetSeasonTVFailureState(this.msg);

  @override
  List<Object> get props => [msg];
}
