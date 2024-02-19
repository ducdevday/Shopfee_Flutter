import 'package:equatable/equatable.dart';

abstract class AppException implements Exception {
  final String message;

  AppException({this.message = ""});
}

class ServerFailure extends AppException {
  ServerFailure({super.message});
}

class InvalidInputFailure extends AppException {
  InvalidInputFailure({super.message});
}
