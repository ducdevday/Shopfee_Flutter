import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> initField() async {
    emit(RegisterLoaded());
  }

  Future<void> addField(String field, String value) async {
    if (state is RegisterLoaded) {
      final currentState = state as RegisterLoaded;
      if (field == 'First Name') {
        emit(RegisterLoaded(
            firstName: value,
            lastName: currentState.lastName,
            email: currentState.email,
            password: currentState.password));
      } else if (field == 'Last Name') {
        emit(RegisterLoaded(
            firstName: currentState.firstName,
            lastName: value,
            email: currentState.email,
            password: currentState.password));
      } else if (field == 'Email') {
        emit(RegisterLoaded(
            firstName: currentState.firstName,
            lastName: currentState.lastName,
            email: value,
            password: currentState.password));
      } else if (field == 'Password') {
        emit(RegisterLoaded(
            firstName: currentState.firstName,
            lastName: currentState.lastName,
            email: currentState.email,
            password: value));
      }
    }
  }
}
