class AppConstants {
  static const String baseUrl = "https://api.themoviedb.org/3/";
  static const String baseImageUrl = "https://image.tmdb.org/t/p/w500";
  static const String myKey = "e8a8e95f2646922aaafaf405239d1ed3";

  //Movies
  static const String moviePath = "movie";
  static const String endPointPopular = "popular";
  static const String endPointNowPlaying = "now_playing";
  static const String endPointTopRated = "top_rated";
  static const String pathPopularMovie = "$moviePath/$endPointPopular";
  static const String pathNowPlayingMovie = "$moviePath/$endPointNowPlaying";
  static const String pathTopRatedMovie = "$moviePath/$endPointTopRated";

  static String parseMovieDetailsPath(int movieId) => "$moviePath/$movieId";

  static String parseMovieRecommendationPath(int movieId) =>
      "$moviePath/$movieId/recommendations";

  //TVS
  static const String tvPath = "tv";
  static const String endPointOnAir = "on_the_air";
  static const String endPointPopularTv = "popular";
  static const String endPointTopRatedTv = "top_rated";
  static const String pathOnAirTv = "$tvPath/$endPointOnAir";
  static const String pathPopularTv = "$tvPath/$endPointPopularTv";
  static const String pathTopRatedTv = "$tvPath/$endPointTopRatedTv";

  static String parseTVDetailsPath(int tvId) => "$tvPath/$tvId";

  static String parseTVRecommendationPath(int movieId) =>
      "$tvPath/$movieId/recommendations";

  static String parseTVSeasonPath(int movieId, int season) =>
      "tv/$movieId/season/$season";

  //Image
  static String parseImagePath(String path) => "$baseImageUrl$path";
}
