import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:clean_architature_movie_app/tvs/presentation/components/on_air_tv_component.dart';
import 'package:clean_architature_movie_app/tvs/presentation/components/popular_tv_component.dart';
import 'package:clean_architature_movie_app/tvs/presentation/components/top_rated_tv_component.dart';
import 'package:clean_architature_movie_app/tvs/presentation/controllers/tv_bloc.dart';
import 'package:clean_architature_movie_app/tvs/presentation/screens/tv_popular_screen.dart';
import 'package:clean_architature_movie_app/tvs/presentation/screens/tv_top_rated_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class TvsScreen extends StatefulWidget {
  const TvsScreen({Key? key}) : super(key: key);

  @override
  State<TvsScreen> createState() => _TvsScreenState();
}

class _TvsScreenState extends State<TvsScreen> {
  ConnectivityResult? _connectivityResult;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> streamSubscription;

  Future<void> initConnectivity() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      throw (e.toString());
    }
    if (!mounted) {
      Future.value(null);
    }
    return _updateConnectivityStatus(connectivityResult);
  }

  _updateConnectivityStatus(ConnectivityResult connectivityResult) async {
    setState(() {
      _connectivityResult = connectivityResult;
    });
  }

  @override
  void initState() {
    initConnectivity();
    streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_connectivityResult == ConnectivityResult.mobile ||
        _connectivityResult == ConnectivityResult.wifi) {
      return Builder(builder: (context) {
        context.read<TvBloc>().add(const GetOnAirTVEvent());
        context.read<TvBloc>().add(const GetPopularTVEvent());
        context.read<TvBloc>().add(const GetTopRatedTVEvent());
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          key: const Key('movieScrollView'),
          child: FadeIn(
            duration: const Duration(milliseconds: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OnAirTVComponent(),
                Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.15,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const TVPopularScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const [
                              Text(
                                'See More',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16.0,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const PopularTVComponent(),
                Container(
                  margin: const EdgeInsets.fromLTRB(
                    16.0,
                    24.0,
                    16.0,
                    8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Rated",
                        style: GoogleFonts.poppins(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.15,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const TVTopRatedScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const [
                              Text(
                                'See More',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16.0,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const TopRatedTVComponent(),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        );
      });
    } else {
      return Center(
        child: SizedBox(
            width: 210, child: Lottie.asset("assets/json/no_connection.json")),
      );
    }
  }
}
