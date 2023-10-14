part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadHome extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class ChooseCategoryHome extends HomeEvent {
  final String id;

  ChooseCategoryHome({required this.id});

  @override
  List<Object> get props => [id];
}


