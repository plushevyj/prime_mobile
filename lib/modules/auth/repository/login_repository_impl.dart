import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../core/http/request_handler.dart';
import '../../../core/token/model/token.dart';
import '../../../core/token/repository/token_repository.dart';
import '../../../core/token/repository/token_repository_impl.dart';
import 'login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final TokenRepository tokenRepository;

  const LoginRepositoryImpl({
    this.tokenRepository = const TokenRepositoryImpl(),
  });

  static final _http = GetIt.I.get<Dio>();

  @override
  Future<bool> isLogIn({required username, required password}) async {
    final data = {'username': username, 'password': password, 'role': 1};
    final response = await handleRequest(() => _http.post(
          '/api/v1/login',
          data: data,
        ));
    print(response);
    try {
      final token = Token.fromMap(response.data);
      tokenRepository.saveToken(token);
      return true;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Token?> tryRefresh(Token token) async {
    try {
      final response = await handleRequest(() => _http.post(
            '/api/v1/refresh',
            data: {"refresh_token": token.refresh},
          ));
      final newToken = Token.fromMap(response.data);
      tokenRepository.saveToken(newToken);
      return newToken;
    } catch (error) {
      return null;
    }
  }
}
