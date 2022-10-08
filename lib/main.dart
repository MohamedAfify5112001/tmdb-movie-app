import 'package:clean_architature_movie_app/app/service_locator.dart';
import 'package:clean_architature_movie_app/core/network/dio/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'app/bloc_observer.dart';
import 'introduction/storage/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMoviesModule();
  await initTVSModule();
  await CacheHelper.initPref();
  DioHelper.initDio();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}
