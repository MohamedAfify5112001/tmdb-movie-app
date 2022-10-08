import 'dart:async';

import 'package:clean_architature_movie_app/introduction/onboarding/onboarding_screen.dart';
import 'package:clean_architature_movie_app/introduction/storage/cache_helper.dart';
import 'package:clean_architature_movie_app/movies/presentation/screens/home_layout.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String val = CacheHelper.getValue(key: "splash");

  Timer? _timer;

  void _splashDelay() {
    _timer = Timer(const Duration(seconds: 2), _nextScreen);
  }

  void _nextScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            (val.isNotEmpty) ? const HomeLayout() : const OnBoardingScreen()));
  }

  @override
  void initState() {
    super.initState();
    _splashDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: const Center(
        child: Image(
          width: 230,
          image: AssetImage("assets/images/logo_transparent.png"),
        ),
      ),
    );
  }
}
