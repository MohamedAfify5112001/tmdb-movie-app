import 'package:animate_do/animate_do.dart';
import 'package:clean_architature_movie_app/introduction/component/svg_image_component.dart';
import 'package:clean_architature_movie_app/introduction/model/onboarding_model.dart';
import 'package:clean_architature_movie_app/introduction/storage/cache_helper.dart';
import 'package:clean_architature_movie_app/movies/presentation/screens/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController(initialPage: 0);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: FadeInDown(
              duration: const Duration(seconds: 3),
              child: Column(
                children: [
                  const SizedBox(
                    height: 110.0,
                  ),
                  Expanded(
                    flex: 3,
                    child: PageView.builder(
                      itemBuilder: (context, index) =>
                          _buildOnBoardingItem(onBoardingItem[index]),
                      physics: const BouncingScrollPhysics(),
                      itemCount: 3,
                      controller: controller,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SmoothPageIndicator(
                          controller: controller,
                          count: 3,
                          effect: ExpandingDotsEffect(
                              dotColor: Colors.grey.shade600,
                              activeDotColor: Colors.red,
                              dotWidth: 10.0,
                              dotHeight: 10.0,
                              expansionFactor: 3,
                              spacing: 7.0),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 21.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeLayout()));
                                CacheHelper.putValue(
                                        key: "splash", val: 'NoOnBoarding');
                              },
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              child: Text(
                                textAlign: TextAlign.center,
                                "Get Started",
                                style: GoogleFonts.poppins(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildOnBoardingItem(OnBoardingModel model) {
    return Column(
      children: [
        SvgImageComponent(
          height: (model.title != "No Commitment") ? 348 : 300,
          width: (model.title != "No Commitment") ? 348 : 300,
          path: model.pathImage,
        ),
        const SizedBox(
          height: 14.0,
        ),
        Text(
          model.title,
          style: GoogleFonts.poppins(
              fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 12.0,
        ),
        SizedBox(
          width: 300,
          child: Text(
            model.describtion,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.white,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
