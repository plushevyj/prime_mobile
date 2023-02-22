import 'package:flutter/foundation.dart';

class ConvertTo<T> {
  Future<T> item(dynamic data, dynamic builder) async {
    return await compute((_) => builder(data), null);
  }

  Future<List<T>> list(List<dynamic> data, dynamic builder) async {
    return await compute((_) => data.map<T>((e) => builder(e)).toList(), null);
  }
}