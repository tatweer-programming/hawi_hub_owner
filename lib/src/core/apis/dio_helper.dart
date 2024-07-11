import 'package:dio/dio.dart';
import 'package:hawi_hub_owner/src/core/apis/api.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: ApiManager.baseUrl,
      headers: {
        "Authorization": ApiManager.authToken,
        // "Connection": "keep-alive",
        'Content-Type': 'application/json',
      },
      contentType: "application/json",
      // connectTimeout: const Duration(seconds: 20),
      // receiveTimeout: const Duration(seconds: 20),
    ));
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': token,
    };
    return dio.get(
      path,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String path,
    Map<String, dynamic>? query,
    dynamic data,
    String? token,
  }) async {
    return dio.post(
      path,
      queryParameters: query,
      data: data,options: Options(
        headers: {
          'Content-Type': 'application/json',
        }
      )
    );
  }

  static Future<Response> putData({
    required String path,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String? token,
  }) async {
    return await dio.put(
      path,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putDataFormData({
    required String path,
    Map<String, dynamic>? query,
    required FormData data,
    String? token,
  }) async {
    return await dio.put(
      path,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String path,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return dio.delete(
      path,
      queryParameters: query,
    );
  }

  static Future<Response> postFormData(String path, FormData formData,
      {Map<String, dynamic>? query}) async {
    return dio.post(path, data: formData, queryParameters: query);
  }
}
