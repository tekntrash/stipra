import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object?> get props => properties;
}

// General failures
class ServerFailure extends Failure {
  final String? errorMessage;
  ServerFailure({this.errorMessage}) : super([errorMessage]);
}

class PhoneVerifyFailure extends Failure {
  final String? errorMessage;
  final dynamic userModel;
  PhoneVerifyFailure({this.errorMessage, required this.userModel})
      : super([errorMessage, userModel]);
}

class EmailVerifyFailure extends Failure {
  final String? errorMessage;
  final String otp;
  EmailVerifyFailure({this.errorMessage, required this.otp})
      : super([errorMessage, otp]);
}

class PhoneSmsExceededLimit extends Failure {
  final String? errorMessage;
  PhoneSmsExceededLimit({
    this.errorMessage,
  }) : super([
          errorMessage,
        ]);
}

class CacheFailure extends Failure {}

class DeletedFileFailure extends Failure {}

class NetworkFailure extends Failure {
  NetworkFailure() : super([]);
}
