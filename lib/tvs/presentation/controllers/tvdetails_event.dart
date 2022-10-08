part of 'tvdetails_bloc.dart';

abstract class TVDetailsEvent extends Equatable {
  const TVDetailsEvent();
}

class GetTVDetailsEvent extends TVDetailsEvent {
  final int id;

  const GetTVDetailsEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetTVRecommendationEvent extends TVDetailsEvent {
  final int id;

  const GetTVRecommendationEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetTVSeasonEvent extends TVDetailsEvent {
  final int id;
  final int seasonNumber;

  @override
  List<Object> get props => [id, seasonNumber];

  const GetTVSeasonEvent(this.id, this.seasonNumber);
}
