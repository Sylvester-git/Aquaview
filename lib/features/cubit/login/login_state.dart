part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoggingIn extends LoginState {}

class ErrorLoggingIn extends LoginState {
  final String errormessage;

  @override
  List<Object> get props => [errormessage];

  const ErrorLoggingIn({required this.errormessage});
}

class LoggedIn extends LoginState {}
