part of 'my_bottom_navigation_bar_cubit.dart';

abstract class MyBottomNavigationBarState extends Equatable {
  const MyBottomNavigationBarState();
}

class MyBottomNavigationBarInitial extends MyBottomNavigationBarState {
  @override
  List<Object> get props => [];
}

class MyBottomNavigationBarLoaded extends MyBottomNavigationBarState {
  final int selectedIndex;

  const MyBottomNavigationBarLoaded({
    required this.selectedIndex,
  });

  @override
  List<Object> get props => [selectedIndex];
}

class MyBottomNavigationChangePage extends MyBottomNavigationBarState {
  @override
  List<Object> get props => [];
}