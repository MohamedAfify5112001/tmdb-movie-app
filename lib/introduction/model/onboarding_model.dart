import 'package:equatable/equatable.dart';

class OnBoardingModel extends Equatable {
  final String pathImage;
  final String title;
  final String describtion;

  const OnBoardingModel(this.pathImage, this.title, this.describtion);

  @override
  List<Object> get props => [pathImage, title, describtion];
}

List<OnBoardingModel> onBoardingItem = [
  const OnBoardingModel("assets/images/cinema.svg", "Cinema On Demand",
      "Enjoy the cinema on the go. Rent movies and stream them for as long as you want."),
  const OnBoardingModel("assets/images/horrior_movie.svg", "Watch Anywhere",
      "Stream all of your favorite movies on your phone, tablet, and laptop for one low price"),
  const OnBoardingModel("assets/images/video_streaming.svg", "No Commitment",
      "Join today FREE! Upgrade or Cancel at anytime."),
];
