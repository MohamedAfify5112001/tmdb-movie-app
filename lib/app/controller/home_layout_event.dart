part of 'home_layout_bloc.dart';

@immutable
abstract class HomeLayoutEvent extends Equatable {
  const HomeLayoutEvent();
}

class HomeLayoutAllScreensEvent extends HomeLayoutEvent {
  final int currentIndex;

  const HomeLayoutAllScreensEvent(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
