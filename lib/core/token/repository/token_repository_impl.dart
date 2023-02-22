import 'package:hive/hive.dart';

import '../model/token.dart';
import 'token_repository.dart';

class TokenRepositoryImpl implements TokenRepository {
  const TokenRepositoryImpl();

  @override
  Future<void> clearToken() async => await (await _openStorage()).clear();

  @override
  Future<Token?> getToken() async {
    final storage = await _openStorage();
    final tokenMap = _tokenConverter(storage.get('token'));
    return tokenMap == null ? null : Token.fromMap(tokenMap);
  }

  @override
  Future<void> saveToken(Token token) async {
    await (await _openStorage()).put('token', token.toMap());
  }

  Future<Box<dynamic>> _openStorage() async => await Hive.openBox('token');

  Map<String, dynamic>? _tokenConverter(dynamic rawToken) {
    if (rawToken == null) return null;
    Map<String, dynamic> map = Map.from(rawToken);
    return map;
  }
}
