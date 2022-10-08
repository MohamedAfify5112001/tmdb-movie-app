import 'package:equatable/equatable.dart';

abstract class BaseTVDetailsParameter extends Equatable {
  final int id;

  const BaseTVDetailsParameter(this.id);

  @override
  List<Object> get props => [id];
}

class TVAllDetailsParameter extends BaseTVDetailsParameter {
  const TVAllDetailsParameter(super.id);
}

class TVRecommendationParameter extends BaseTVDetailsParameter {
  const TVRecommendationParameter(super.id);
}

class TVSeasonsParameter extends BaseTVDetailsParameter {
  final int seasonNumber;

  const TVSeasonsParameter(super.id, this.seasonNumber);
}
