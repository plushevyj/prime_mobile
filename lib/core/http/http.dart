import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../modules/auth/repository/login_repository.dart';
import '../../modules/auth/repository/login_repository_impl.dart';
import '../token/model/token.dart';
import '../token/repository/token_repository.dart';
import '../token/repository/token_repository_impl.dart';

class Http {
  const Http();

  Dio createClient() => Dio()
    ..options.baseUrl = dotenv.env['BASE_URL'] ?? 'Unable access url!'
    ..options.connectTimeout = const Duration(microseconds: 10000)
    ..options.receiveTimeout = const Duration(microseconds: 10000)
    ..interceptors.add(
      InterceptorsWrapper(onRequest: _addToken, onError: _throwError),
    );

  static const TokenRepository tokenRepository = TokenRepositoryImpl();
  static const LoginRepository loginRepository = LoginRepositoryImpl();

  static Token? _token;

  static Future<void> _addToken(options, handler) async {
    final token = await tokenRepository.getToken();
    if (token != null) {
      _token = token;
      options.headers['Authorization'] = 'Bearer ${token.access}';
      print(
        '${("-" * 100).toString()}\n'
            '${token.access}\n'
            '${("-" * 100).toString()}\n',
      );
    }
    return handler.next(options);
  }

  static void _throwError(DioError error, ErrorInterceptorHandler handler) {
    String? exceptionText;
    // Todo describe reaction on all standard Exceptions
    if (error.response?.statusCode == 401 && _token != null) {
      loginRepository.tryRefresh(_token!);
    }
    if (error.response != null) {
      exceptionText = error.response?.data['detail'].toString();
    } else {
      switch (error.error.runtimeType) {
        case SocketException:
          error.error.toString().contains('Failed host lookup')
              ? exceptionText = 'Ошибка подключения к серверу'
              : exceptionText = 'Отсутствует подключение к интернету';
          break;
        default:
          exceptionText = 'Возникло исключение:\n${error.error}';
      }
    }
    if (exceptionText != null) throw exceptionText;
  }
}
