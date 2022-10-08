import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_architature_movie_app/movies/presentation/screens/movie_screen.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../tvs/presentation/screens/tvs_screen.dart';

part 'home_layout_event.dart';

part 'home_layout_state.dart';

class HomeLayoutBloc extends Bloc<HomeLayoutEvent, HomeLayoutState> {
  int currentIndex = 0;
  List<Widget> screens = [
    const MoviesScreen(),
    const TvsScreen(),
  ];

  HomeLayoutBloc() : super(HomeLayoutInitial()) {
    on<HomeLayoutAllScreensEvent>((event, emit) {
      currentIndex = event.currentIndex;
      emit(HomeLayoutAllScreensState());
    });
  }
}
