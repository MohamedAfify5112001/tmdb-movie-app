part of 'tv_bloc.dart';

@immutable
abstract class TvState extends Equatable {
  const TvState();

  @override
  List<Object> get props => [];
}

class TvInitial extends TvState {
  const TvInitial();
}

class GetOnAirLoadedState extends TvState {
  const GetOnAirLoadedState();
}

class GetOnAirLoadingState extends TvState {
  const GetOnAirLoadingState();
}

class GetOnAirFailedState extends TvState {
  final String msg;

  const GetOnAirFailedState(this.msg);
}

class GetPopularTvLoadedState extends TvState {
  const GetPopularTvLoadedState();
}

class GetPopularTvLoadingState extends TvState {
  const GetPopularTvLoadingState();
}

class GetPopularTvFailedState extends TvState {
  final String msg;

  const GetPopularTvFailedState(this.msg);
}

class GetTopRatedTvLoadedState extends TvState {
  const GetTopRatedTvLoadedState();
}

class GetTopRatedTvLoadingState extends TvState {
  const GetTopRatedTvLoadingState();
}

class GetTopRatedTvFailedState extends TvState {
  final String msg;

  const GetTopRatedTvFailedState(this.msg);
}
