import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clean_architature_movie_app/movies/presentation/controllers/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_constants.dart';
import '../../domain/entities/movie.dart';
import '../screens/movie_details_screen.dart';

class NowPlayingComponent extends StatefulWidget {
  const NowPlayingComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<NowPlayingComponent> createState() => _NowPlayingComponentState();
}

class _NowPlayingComponentState extends State<NowPlayingComponent> {
  List<Movie> nowPlayingMovie = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieBloc, MovieState>(
      listener: (context, state) {
        if (state is GetNowPlayingLoadedState) {
          nowPlayingMovie = state.nowPlayingMovie;
        }
      },
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return (state is GetNowPlayingLoadingState)
            ? SizedBox(
                height: 400.0,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey.shade700,
                  ),
                ),
              )
            : FadeIn(
                duration: const Duration(milliseconds: 500),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 400.0,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {},
                  ),
                  items: nowPlayingMovie.map(
                    (item) {
                      return GestureDetector(
                        key: const Key('openMovieMinimalDetail'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailScreen(id: item.id)));
                        },
                        child: Stack(
                          children: [
                            ShaderMask(
                              shaderCallback: (rect) {
                                return const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    // fromLTRB
                                    Colors.transparent,
                                    Colors.black,
                                    Colors.black,
                                    Colors.transparent,
                                  ],
                                  stops: [0, 0.3, 0.5, 1],
                                ).createShader(
                                  Rect.fromLTRB(0, 0, rect.width, rect.height),
                                );
                              },
                              blendMode: BlendMode.dstIn,
                              child: CachedNetworkImage(
                                height: 560.0,
                                imageUrl: AppConstants.parseImagePath(
                                    item.backdropPath),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          color: Colors.redAccent,
                                          size: 16.0,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          'Now Playing'.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: Text(
                                      item.originalTitle,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 24, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              );
      },
    );
  }
}
