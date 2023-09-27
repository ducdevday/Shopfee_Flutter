import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> initField() async {
    emit(LoginLoaded());
  }

  Future<void> addField(String field, String value) async {
    if (state is LoginLoaded) {
      final currentState = state as LoginLoaded;
      if (field == 'Email') {
        emit(LoginLoaded(email: value, password: currentState.password));
      } else if (field == 'Password') {
        emit(LoginLoaded(email: currentState.email, password: value));
      }
    }
  }
}
