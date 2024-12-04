import 'package:dio/dio.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(message: 'No Internet Connection');
        case DioExceptionType.cancel:
          return ApiErrorModel(message: 'Request to server was canceld');
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(message: 'Connection timeout with server');
        case DioExceptionType.unknown:
          return ApiErrorModel(
              message: 'Opps There was an Error, Please try again');
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(message: 'Receive timeout with Server');
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(message: 'Send timeout with Server');
        case DioExceptionType.badCertificate:
          return ApiErrorModel(message: 'bad certificate with server');

        case DioExceptionType.badResponse:
          return _handleBadResponse(
              error.response?.data, error.response?.statusCode);

        default:
          return ApiErrorModel(message: 'Something went wrong');
      }
    } else {
      return ApiErrorModel(message: "Unknown error occurred");
    }
  }

  static ApiErrorModel _handleBadResponse(
      dynamic responseData, int? statusCode) {
    if (responseData != null) {
      if (responseData is Map<String, dynamic>) {
        // Check for error message in the response
        String errorMessage =
            responseData['message'] ?? 'Unknown error occurred';
        return ApiErrorModel(message: errorMessage);
      } else {
        return ApiErrorModel(message: 'Unexpected error format from server');
      }
    } else {
      switch (statusCode) {
        case 400:
          return ApiErrorModel(
              message: 'Bad request. Please check the data sent.');
        case 401:
          return ApiErrorModel(message: 'Unauthorized. Please log in again.');
        case 403:
          return ApiErrorModel(
              message: 'Forbidden. You do not have permission.');
        case 404:
          return ApiErrorModel(
              message: 'Not found. The requested resource was not found.');
        case 500:
          return ApiErrorModel(
              message: 'Server error. Please try again later.');
        default:
          return ApiErrorModel(
              message: 'Something went wrong with status code $statusCode');
      }
    }
  }
}

class ApiErrorModel {
  final String message;

  ApiErrorModel({required this.message});
}
