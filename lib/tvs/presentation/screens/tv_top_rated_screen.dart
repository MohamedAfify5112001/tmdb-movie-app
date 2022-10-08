import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architature_movie_app/tvs/presentation/controllers/tv_bloc.dart';
import 'package:clean_architature_movie_app/tvs/presentation/screens/tv_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/app_constants.dart';
import '../../domain/entities/tvs.dart';

class TVTopRatedScreen extends StatelessWidget {
  const TVTopRatedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<TvBloc>(context),
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey.shade900,
          title: Text(
            "Top Rated TVs",
            style: GoogleFonts.poppins(fontSize: 18.0, color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: FadeInDown(
                  duration: const Duration(milliseconds: 900),
                  child: ListView.separated(
                    itemCount:
                        BlocProvider.of<TvBloc>(context).topRatedTvData.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => _buildCardPopularMovie(
                        BlocProvider.of<TvBloc>(context).topRatedTvData[index],
                        context),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card _buildCardPopularMovie(TV tv, BuildContext context) {
    return Card(
      color: Colors.grey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TVDetailsScreen(id: tv.id)));
                },
                child: CachedNetworkImage(
                  width: 120.0,
                  height: 170.0,
                  fit: BoxFit.cover,
                  imageUrl: AppConstants.parseImagePath(tv.backdropPath ?? ""),
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
                ),
              ),
            ),
            const SizedBox(
              width: 14,
            ),
            Expanded(child: _movieDetails(tv))
          ],
        ),
      ),
    );
  }

  Widget _movieDetails(TV tv) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tv.originalName,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
              fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 2.0,
                horizontal: 8.0,
              ),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                tv.airDate.split('-')[0],
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              width: 18.0,
            ),
            _buildRating(tv),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Text(
          tv.overview,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: GoogleFonts.poppins(
              fontSize: 13.0, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Row _buildRating(TV tv) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
          size: 20.0,
        ),
        const SizedBox(width: 4.0),
        Text(
          ((tv.voteAverage) / 2).toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
