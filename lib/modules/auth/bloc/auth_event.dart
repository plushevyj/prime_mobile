part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthAppStarted extends AuthEvent {
  const AuthAppStarted();
}

class AuthLogIn extends AuthEvent {
  final String username;
  final String password;

  const AuthLogIn({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class AuthLogOut extends AuthEvent {
  const AuthLogOut();
}
