import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/app_constants.dart';
import '../controllers/tv_bloc.dart';
import '../screens/tv_details_screen.dart';

class PopularTVComponent extends StatelessWidget {
  const PopularTVComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvBloc, TvState>(
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
              itemCount: context.watch<TvBloc>().popularTvData.length,
              itemBuilder: (context, index) {
                final tv = context.watch<TvBloc>().popularTvData[index];
                return Container(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TVDetailsScreen(id: tv.id)));
                    },
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      child: CachedNetworkImage(
                        width: 120.0,
                        fit: BoxFit.cover,
                        imageUrl:
                            AppConstants.parseImagePath(tv.backdropPath ?? ""),
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
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
