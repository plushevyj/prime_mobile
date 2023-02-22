class Token {
  final String _access;

  String get access => _access;

  final String _refresh;

  String get refresh => _refresh;

  Token.fromMap(Map<String, dynamic> map)
      : _access = map['access_token'] ?? '',
        _refresh = map['refresh_token'] ?? '';

  Map<String, String> toMap() => {
        'access_token': _access,
        'refresh_token': _refresh,
      };
}
