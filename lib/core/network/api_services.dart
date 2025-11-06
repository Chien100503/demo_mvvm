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
    // add interceptors if needed
    d.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return ApiService._internal(d);
  }
}
