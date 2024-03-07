part of register;

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterReady extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterFinished extends RegisterState {
  final RegisterEntity registerEntity;

  @override
  List<Object> get props => [];

  const RegisterFinished({
    required this.registerEntity,
  });
}
