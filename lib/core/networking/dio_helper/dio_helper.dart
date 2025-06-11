import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:smart_cleaning_application/core/helpers/cache_helper/cache_helper.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/networking/api_error_handler/api_error_handler.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/logic/login_cubit_cubit.dart';
import 'package:smart_cleaning_application/features/screens/auth/login/ui/screen/login_screen.dart';

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
    dio?.options.headers['Authorization'] = 'Bearer $token';
  }

  // static void addDioInterceptor() {
  //   dio?.interceptors.add(
  //     PrettyDioLogger(
  //       requestBody: true,
  //       requestHeader: true,
  //       responseHeader: true,
  //     ),
  //   );
  // }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            await handleUnauthorized();
          }
          handler.next(error);
        },
      ),
    );

    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }

  /// Handle 401 by clearing cache and navigating to login screen
  static Future<void> handleUnauthorized() async {
    await CacheHelper.clearAllData();
    await CacheHelper.clearAllSecuredData();

    token = null;
    uId = null;
    role = null;
    isBoarding = null;

    // Navigate to login screen
    AppNavigator.navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => LoginCubit(),
                child: const LoginScreen(),
              )),
      (route) => false,
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
    Map<String, dynamic>? data,
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

  static Future<Response?> putData2({
    required String url,
    Map<String, dynamic>? query,
    required FormData data,
  }) async {
    try {
      return await dio!.put(url, queryParameters: query, data: data);
    } on DioException catch (e) {
      final error = ApiErrorHandler.handle(e);
      throw Exception(error.message);
    }
  }

  /// DELETE request
  static Future<Response?> deleteData({
    required String url,
    Map<String, dynamic>? query,
     Map<String, dynamic>? data,
  }) async {
    try {
      return await dio!.delete(url, queryParameters: query, data: data);
    } on DioException catch (e) {
      final error = ApiErrorHandler.handle(e);
      throw Exception(error.message);
    }
  }
}

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}
