import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clean_architature_movie_app/tvs/presentation/screens/tv_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/app_constants.dart';
import '../controllers/tv_bloc.dart';

class OnAirTVComponent extends StatelessWidget {
  const OnAirTVComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvBloc, TvState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return FadeIn(
            duration: const Duration(milliseconds: 500),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 400.0,
                viewportFraction: 1.0,
                autoPlay: true,
              ),
              items: context.watch<TvBloc>().onAirTvData.map(
                (item) {
                  return GestureDetector(
                    key: const Key('openMovieMinimalDetail'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TVDetailsScreen(id: item.id)));
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
                                item.backdropPath ?? ""),
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                CachedNetworkImage(
                                    height: 180.0,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey[850]!,
                                          highlightColor: Colors.grey[800]!,
                                          child: Container(
                                            height: 170.0,
                                            width: 120.0,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg"),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.redAccent,
                                      size: 16.0,
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      'On THE Air'.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 16.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  item.originalName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 22, color: Colors.white),
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
        });
  }
}
