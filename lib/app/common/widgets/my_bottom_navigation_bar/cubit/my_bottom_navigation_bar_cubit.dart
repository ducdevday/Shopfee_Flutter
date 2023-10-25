import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_bottom_navigation_bar_state.dart';

class MyBottomNavigationBarCubit extends Cubit<MyBottomNavigationBarState> {
  MyBottomNavigationBarCubit() : super(MyBottomNavigationBarInitial());

  void selectPage(int page){
    emit(MyBottomNavigationBarLoaded(selectedIndex: page));
  }
}
