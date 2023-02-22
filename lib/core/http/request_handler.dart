import 'package:dio/dio.dart';

Future<Response> handleRequest(dynamic request) async {
  try {
    return await request();
  } on DioError catch (error) {
    if (error.response != null) {
      print(error.response!.data);
      print(error.response!.headers);
      print(error.response!.requestOptions);
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      print(error.requestOptions.toString());
      print(error.message.toString());
      print(error.error.toString());
      print(error.error);
    }
    throw error.response?.data == null
        ? error.error
        : error.response?.data['detail'];
  } catch (error) {
    rethrow;
  }
}
