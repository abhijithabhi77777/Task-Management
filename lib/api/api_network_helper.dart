import 'dart:async';

import 'package:dio/dio.dart';

class NetworkHelper {
  Dio? dio;

  NetworkHelper() {
    if (dio == null) {
      final BaseOptions options = BaseOptions(
        baseUrl: "http://localhost:8080",
        //"http://192.168.1.72:3306", //"http://localhost:8081",
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      );

      dio = Dio(options);
    }
  }

  Future<Response> getWithParams(
      {required String url, Map<String, dynamic>? parameterMap}) async {
    print('URL in get:$url');
    print('Params map in get:$parameterMap');

    Response response = await dio!.get(url,
        queryParameters: parameterMap,
        options: Options(headers: {
          "Connection": "Keep-Alive",
        }));
    print('URL:  ${response.realUri}');
    try {
      print('Response:$response');
      print('Get: ${response.data}');
    } on DioException catch (e) {
      print('Network Helper Get Error: $e');
    }
    return response;
  }

  Future<Response> post(String url) async {
    print('URL in POST:$url');
    final response = await dio!.post(url);
    try {
      print('Response:$response');
      print('Get: ${response.data}');
    } on DioException catch (e) {
      print('Network Helper Post Error: $e');
      rethrow;
    }
    return response;
  }

  Future<Response> postWithBody({
    required String url,
    dynamic body,
    Map<String, String>? headers,
    String? token,
  }) async {
    print('URL:$url');
    print('Body:$body');
    try {
      final response = await dio!.post(
        url,
        data: body,
        options: Options(
            headers: headers ??
                {
                  "Content-Type": "application/json",
                  "Authorization": "Bearer $token",
                }),
      );
      print('Response:$response');
      print('Get: ${response.data}');
      return response;
    } on DioException catch (e) {
      print("postWithBody catch${e.response?.statusCode}");
      print(e.response?.data);
      print(e.response?.extra);
      print(e.response?.extra);
      rethrow;
    }
  }

  Future<Response> putWithParams({
    required String url,
    Map<String, dynamic>? parameterMap,
    dynamic body,
    Map<String, String>? headers,
    String? token,
  }) async {
    print('URL in PUT: $url');
    print('Params map in PUT: $parameterMap');
    print('Body in PUT: $body');

    try {
      final response = await dio!.put(
        url,
        queryParameters: parameterMap,
        data: body,
        options: Options(
          headers: headers ??
              {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token",
              },
        ),
      );

      print('Response in PUT: $response');
      print('Data in PUT: ${response.data}');
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        print("PUT Request Error Status Code: ${e.response!.statusCode}");
        print("Error Data: ${e.response!.data}");
        print("Error Extra: ${e.response!.extra}");
      } else {
        print("Network Helper PUT Error: $e");
      }
      rethrow;
    }
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? parameterMap,
    Map<String, String>? headers,
    String? token,
  }) async {
    print('URL in DELETE: $url');
    print('Params map in DELETE: $parameterMap');

    try {
      final response = await dio!.delete(
        url,
        queryParameters: parameterMap,
        options: Options(
          headers: headers ??
              {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token",
              },
        ),
      );

      print('Response in DELETE: $response');
      print('Data in DELETE: ${response.data}');
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        print("DELETE Request Error Status Code: ${e.response!.statusCode}");
        print("Error Data: ${e.response!.data}");
        print("Error Extra: ${e.response!.extra}");
      } else {
        print("Network Helper DELETE Error: $e");
      }
      rethrow;
    }
  }
}
