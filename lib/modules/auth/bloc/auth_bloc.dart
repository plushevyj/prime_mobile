import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/token/repository/token_repository.dart';
import '../../../core/token/repository/token_repository_impl.dart';
import '../repository/login_repository.dart';
import '../repository/login_repository_impl.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginRepository repository;
  final TokenRepository tokenRepository;

  AuthBloc({
    this.repository = const LoginRepositoryImpl(),
    this.tokenRepository = const TokenRepositoryImpl(),
  }) : super(const AuthInitial()) {
    on<AuthAppStarted>(_appStarted);
    on<AuthLogIn>(_logIn);
    on<AuthLogOut>(_logOut);
  }

  Future<void> _appStarted(
    AuthAppStarted event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final currentToken = await tokenRepository.getToken();
      if (currentToken == null) {
        emit(const AuthUnauthenticated());
        return;
      }
      final token = await repository.tryRefresh(currentToken);
      token != null
          ? emit(const AuthAuthenticated())
          : emit(const AuthUnauthenticated());
    } catch (error) {
      emit(AuthError(error.toString()));
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _logIn(AuthLogIn event, Emitter<AuthState> emit) async {
    try {
      var response = await repository.isLogIn(
        username: event.username,
        password: event.password,
      );
      response
          ? emit(const AuthAuthenticated())
          : emit(const AuthUnauthenticated());
    } catch (error) {
      emit(AuthError(error.toString()));
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _logOut(AuthLogOut event, Emitter<AuthState> emit) async {
    tokenRepository.clearToken();
    emit(const AuthUnauthenticated());
  }
}
