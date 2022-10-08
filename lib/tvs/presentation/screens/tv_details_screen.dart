import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architature_movie_app/app/service_locator.dart';
import 'package:clean_architature_movie_app/core/utils/app_constants.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/genre_tv.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/recommendation_tvs.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/season.dart';
import 'package:clean_architature_movie_app/tvs/domain/entities/tv_details.dart';
import 'package:clean_architature_movie_app/tvs/presentation/controllers/tvdetails_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class TVDetailsScreen extends StatefulWidget {
  final int id;

  const TVDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<TVDetailsScreen> createState() => _TVDetailsScreenState();
}

class _TVDetailsScreenState extends State<TVDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => instanceServiceLocator<TVDetailsBloc>()
        ..add(GetTVDetailsEvent(widget.id))
        ..add(GetTVRecommendationEvent(widget.id)),
      child: BlocBuilder<TVDetailsBloc, TVDetailsState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.grey.shade900,
              body: OfflineBuilder(
                connectivityBuilder: (
                  BuildContext context,
                  ConnectivityResult connectivity,
                  Widget child,
                ) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;
                  if (connected) {
                    if (BlocProvider.of<TVDetailsBloc>(context).tvDetails !=
                        null) {
                      return TVDetailsContent(
                          tvDetails: BlocProvider.of<TVDetailsBloc>(context)
                              .tvDetails);
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
                          child:
                              Lottie.asset("assets/json/no_connection.json")),
                    );
                  }
                },
                child: Center(
                  child: CircularProgressIndicator(color: Colors.grey.shade700),
                ),
              ));
        },
      ),
    );
  }
}

class TVDetailsContent extends StatefulWidget {
  final TVDetails? tvDetails;

  const TVDetailsContent({
    Key? key,
    required this.tvDetails,
  }) : super(key: key);

  @override
  State<TVDetailsContent> createState() => _TVDetailsContentState();
}

class _TVDetailsContentState extends State<TVDetailsContent>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPoster(context),
          const SizedBox(
            height: 10,
          ),
          _buildContent(),
          Row(
            children: [
              const SizedBox(width: 14),
              Text(
                'More like this'.toUpperCase(),
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: _showRecommendations(
                BlocProvider.of<TVDetailsBloc>(context).recommendationTVSList),
          ),
          /*_buildExpensionPanelForSeason(
              BlocProvider.of<TVDetailsBloc>(context).seasonTVList),*/
        ],
      ),
    );
  }

  _buildExpensionPanelForSeason(List<Season> seasons) {
    List<Season> seasonsList = seasons;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14),
      child: ExpansionPanelList.radio(
        children: List.generate(seasonsList.length,
            (index) => _panelSeason(seasonsList[index], index + 1)),
      ),
    );
  }

  ExpansionPanelRadio _panelSeason(Season season, int index) {
    return ExpansionPanelRadio(
        backgroundColor: Colors.grey.shade800,
        value: season.id,
        headerBuilder: (bc, status) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Season $index",
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2,
                      color: Colors.white)),
            ),
          );
        },
        body: Text(season.episodes[0].overview,
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.2,
                color: Colors.white)));
  }

  FadeIn _buildPoster(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 500),
      child: Stack(
        children: [
          ShaderMask(
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
              imageUrl: AppConstants.parseImagePath(
                  widget.tvDetails?.backdropPath ?? ""),
              fit: BoxFit.cover,
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
          Positioned(
            top: 50,
            left: 10,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContent() {
    return FadeInUp(
      from: 20,
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.tvDetails?.originalName ?? "",
                overflow: TextOverflow.ellipsis,
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
                    widget.tvDetails?.airDate.split('-')[0] ?? "",
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
                      ((widget.tvDetails?.voteAverage ?? 0) / 2)
                          .toStringAsFixed(1),
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
                  "${widget.tvDetails?.sessionNumber} ${((widget.tvDetails?.sessionNumber)! > 1) ? "Seasons" : "Season"}",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(width: 16.0),
                Text(
                  _showDuration(widget.tvDetails?.episodeRuntime[0] ?? 0),
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
              widget.tvDetails?.overview ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 6,
              style: const TextStyle(
                  fontSize: 14.0,
                  height: 1.7,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.2,
                  color: Colors.white),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Genres: ${_showGenres(widget.tvDetails?.genres ?? [])}',
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
    );
  }

  String _showGenres(List<GenreTV> genres) {
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

  Widget _showRecommendations(List<RecommendationTVS> recommendation) {
    if ((recommendation.isNotEmpty)) {
      return GridView.count(
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.7,
        crossAxisCount: 3,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(recommendation.length,
            (index) => _buildGridRecommendationItem(recommendation[index])),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildGridRecommendationItem(RecommendationTVS recommendation) {
    return FadeInUp(
      from: 20,
      duration: const Duration(milliseconds: 500),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        child: CachedNetworkImage(
          imageUrl:
              AppConstants.parseImagePath(recommendation.backdropPath ?? ""),
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
  }
}
