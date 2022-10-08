part of 'tv_bloc.dart';

@immutable
abstract class TvEvent extends Equatable {
  const TvEvent();

  @override
  List<Object> get props => [];
}

class GetOnAirTVEvent extends TvEvent {
  const GetOnAirTVEvent();
}

class GetPopularTVEvent extends TvEvent {
  const GetPopularTVEvent();
}

class GetTopRatedTVEvent extends TvEvent {
  const GetTopRatedTVEvent();
}
