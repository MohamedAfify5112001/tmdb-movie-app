import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architature_movie_app/core/utils/app_constants.dart';
import 'package:clean_architature_movie_app/movies/domain/entities/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/entities/recommendation_movies.dart';
import '../controllers/movie_details_bloc.dart';

class MovieDetailScreen extends StatefulWidget {
  final int id;

  const MovieDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    context.read<MovieDetailsBloc>().add(GetMovieDetailsEvent(widget.id));
    context
        .read<MovieDetailsBloc>()
        .add(GetRecommendationMoviesEvent(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      MovieDetails? movie;
      List<RecommendationMovie> recommendations = [];
      return BlocConsumer<MovieDetailsBloc, MovieDetailsState>(
        listener: (context, state) {
          if (state is GetMovieDetailsLoadedState) {
            movie = state.movieDetails;
          }
          if (state is GetRecommendationMovieLoadedState) {
            recommendations = state.recommendationMovie;
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey.shade900,
            body: OfflineBuilder(
              connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
              ) {
                final bool connected = connectivity != ConnectivityResult.none;
                if (connected) {
                  if (movie != null) {
                    return MovieDetailContent(
                      movie: movie,
                      recommendations: recommendations,
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                          color: Colors.grey.shade700),
                    );
                  }
                } else {
                  return Center(
                    child: SizedBox(
                        width: 210,
                        child: Lottie.asset("assets/json/no_connection.json")),
                  );
                }
              },
              child: Center(
                child: CircularProgressIndicator(color: Colors.grey.shade700),
              ),
            ),
          );
        },
      );
    });
  }
}

class MovieDetailContent extends StatelessWidget {
  final MovieDetails? movie;
  final List<RecommendationMovie> recommendations;

  const MovieDetailContent({
    Key? key,
    required this.movie,
    required this.recommendations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      key: const Key('movieDetailScrollView'),
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.grey.shade900,
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            background: FadeIn(
              duration: const Duration(milliseconds: 500),
              child: ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                      Colors.black,
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.5, 1.0, 1.0],
                  ).createShader(
                    Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                  );
                },
                blendMode: BlendMode.dstIn,
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width,
                  imageUrl: AppConstants.parseImagePath(movie?.backdropPath ??
                      "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: FadeInUp(
            from: 20,
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie?.originalTitle ?? "",
                      style: GoogleFonts.poppins(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: Colors.white)),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          movie?.releaseDate.split('-')[0] ?? "",
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20.0,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            ((movie?.voteAverage ?? 0) / 2).toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(width: 4.0),
                        ],
                      ),
                      const SizedBox(width: 16.0),
                      Text(
                        _showDuration(movie?.runtime ?? 0),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    movie?.overview ?? "",
                    style: const TextStyle(
                        fontSize: 14.0,
                        height: 1.7,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Genres: ${_showGenres(movie?.genres ?? [])}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
          sliver: SliverToBoxAdapter(
            child: FadeInUp(
              from: 20,
              duration: const Duration(milliseconds: 500),
              child: Text(
                'More like this'.toUpperCase(),
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),
        // Tab(text: 'More like this'.toUpperCase()),
        if ((recommendations.isNotEmpty))
          SliverPadding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
              sliver: _showRecommendations(recommendations)),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Widget _showRecommendations(List<RecommendationMovie> recommendation) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return FadeInUp(
            from: 20,
            duration: const Duration(milliseconds: 500),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              child: CachedNetworkImage(
                imageUrl: AppConstants.parseImagePath(
                    recommendation[index].backdropPath ?? ""),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[850]!,
                  highlightColor: Colors.grey[800]!,
                  child: Container(
                    height: 170.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => CachedNetworkImage(
                    height: 180.0,
                    placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[850]!,
                          highlightColor: Colors.grey[800]!,
                          child: Container(
                            height: 170.0,
                            width: 120.0,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                    fit: BoxFit.cover,
                    imageUrl:
                        "https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg"),
                height: 180.0,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        childCount: recommendation.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.7,
        crossAxisCount: 3,
      ),
    );
  }
}
