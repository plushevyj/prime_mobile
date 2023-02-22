import '../../../core/token/model/token.dart';

abstract class LoginRepository {
  Future<bool> isLogIn({required String username, required String password});
  Future<Token?> tryRefresh(Token token);
}
