import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/app_constants.dart';
import '../../../core/utils/dummy.dart';
import '../../domain/entities/movie.dart';
import '../controllers/movie_bloc.dart';
import '../screens/movie_details_screen.dart';

class TopRatedMovieComponent extends StatefulWidget {
  const TopRatedMovieComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<TopRatedMovieComponent> createState() => _TopRatedMovieComponentState();
}

class _TopRatedMovieComponentState extends State<TopRatedMovieComponent> {
  List<Movie> topRatedMovie = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieBloc, MovieState>(
        listener: (context, state) {
          if (state is GetTopRatedLoadedState) {
            topRatedMovie = state.topRatedMovies;
          }
        },
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return FadeIn(
            duration: const Duration(milliseconds: 500),
            child: SizedBox(
              height: 170.0,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: topRatedMovie.length,
                itemBuilder: (context, index) {
                  final movie = topRatedMovie[index];
                  return Container(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailScreen(id: movie.id)));
                      },
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        child: CachedNetworkImage(
                          width: 120.0,
                          fit: BoxFit.cover,
                          imageUrl:
                              AppConstants.parseImagePath(movie.backdropPath),
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
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
