import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: 'https://student.valuxapps.com/api/',
        headers: {
          'Content-Type': 'application/json',
        }));
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token,
    };
    return await dio!.post(url, data: data);
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token,
    };
    return await dio!.put(url, data: data);
  }
}
