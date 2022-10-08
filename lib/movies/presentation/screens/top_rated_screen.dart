import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architature_movie_app/movies/domain/entities/movie.dart';
import 'package:clean_architature_movie_app/movies/presentation/controllers/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/app_constants.dart';
import 'movie_details_screen.dart';

class TopRatedScreen extends StatelessWidget {
  const TopRatedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MovieBloc>(context),
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey.shade900,
          title: Text(
            "Top Rated Movie",
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
                    itemCount: BlocProvider.of<MovieBloc>(context)
                        .topRatedMovies
                        .length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => _buildCardTopRatedMovie(
                        BlocProvider.of<MovieBloc>(context)
                            .topRatedMovies[index],
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

  Card _buildCardTopRatedMovie(Movie movie, BuildContext context) {
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
                      builder: (context) => MovieDetailScreen(id: movie.id)));
                },
                child: CachedNetworkImage(
                  width: 120.0,
                  height: 170.0,
                  fit: BoxFit.cover,
                  imageUrl: AppConstants.parseImagePath(movie.backdropPath),
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(
              width: 14,
            ),
            Expanded(child: _movieDetails(movie))
          ],
        ),
      ),
    );
  }

  Widget _movieDetails(Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.originalTitle,
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
                movie.releaseDate.split('-')[0],
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
            _buildRating(movie),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Text(
          movie.overview,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: GoogleFonts.poppins(
              fontSize: 13.0, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Row _buildRating(Movie movie) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
          size: 20.0,
        ),
        const SizedBox(width: 4.0),
        Text(
          ((movie.voteAverage) / 2).toStringAsFixed(1),
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
