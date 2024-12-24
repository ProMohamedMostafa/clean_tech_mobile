import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/api_error_handler/api_error_handler.dart';

class DioHelper {
  static Dio? dio;

  static Future<Dio> initDio() async {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio(BaseOptions(
        baseUrl: ApiConstants.apiBaseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: timeOut,
        receiveTimeout: timeOut,
      ));
      await setHeaders();
      addDioInterceptor();
      (dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback = (cert, host, port) => true;
        return null; // Accept all certificates
      };
    }
    return dio!;
  }

  /// Add default headers
  static Future<void> setHeaders() async {
    dio?.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token != null ? 'Bearer $token' : '',
    };
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    dio?.options.headers = {
      'Authorization': 'Bearer $token',
    };
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }

  /// GET request
  static Future<Response?> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    try {
      return await dio!.get(url, queryParameters: query);
    } on DioException catch (e) {
      final error = ApiErrorHandler.handle(e);
      throw Exception(error.message);
    }
  }

  /// POST request
  static Future<Response?> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    try {
      return await dio!.post(url, queryParameters: query, data: data);
    } on DioException catch (e) {
      final error = ApiErrorHandler.handle(e);
      throw Exception(error.message);
    }
  }
  static Future<Response?> postData2({
    required String url,
    Map<String, dynamic>? query,
    required FormData data,
  }) async {
    try {
      return await dio!.post(url, queryParameters: query, data: data);
    } on DioException catch (e) {
      final error = ApiErrorHandler.handle(e);
      throw Exception(error.message);
    }
  }

  /// PUT request
  static Future<Response?> putData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      return await dio!.put(url, queryParameters: query, data: data);
    } on DioException catch (e) {
      final error = ApiErrorHandler.handle(e);
      throw Exception(error.message);
    }
  }
}
