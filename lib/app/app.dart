import 'package:clean_architature_movie_app/app/controller/home_layout_bloc.dart';
import 'package:clean_architature_movie_app/app/service_locator.dart';
import 'package:clean_architature_movie_app/introduction/splash/splash_screen.dart';
import 'package:clean_architature_movie_app/movies/presentation/controllers/movie_bloc.dart';
import 'package:clean_architature_movie_app/movies/presentation/controllers/movie_details_bloc.dart';
import 'package:clean_architature_movie_app/movies/presentation/screens/home_layout.dart';
import 'package:clean_architature_movie_app/tvs/presentation/controllers/tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  MyApp._internal();

  static MyApp get instance => MyApp._internal();

  factory MyApp() => instance;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => instanceServiceLocator<HomeLayoutBloc>(),
        ),
        BlocProvider(
          create: (context) => instanceServiceLocator<MovieBloc>(),
        ),
        BlocProvider(
          create: (context) => instanceServiceLocator<MovieDetailsBloc>(),
        ),
        BlocProvider(
          create: (context) => instanceServiceLocator<TvBloc>(),
        ),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: SplashScreen()),
    );
  }
}
