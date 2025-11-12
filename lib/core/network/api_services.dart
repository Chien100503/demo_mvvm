import 'dart:io';

import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService._internal(this.dio);

  factory ApiService({required String baseUrl}) {
    final d = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
    // LogInterceptor có sẵn
    d.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    d.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer YOUR_TOKEN';
          print("Request to: ${options.uri}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("Response [${response.statusCode}]: ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          print("Error: ${e.message}");
          if (e.type == DioExceptionType.connectionTimeout) {
            print("Retrying...");
            return handler.resolve(await d.request(e.requestOptions.path));
          }
          return handler.next(e);
        },
      ),
    );

    return ApiService._internal(d);
  }
}
