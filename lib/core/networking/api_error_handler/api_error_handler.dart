import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/networking/business_error/business_error.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error, {BuildContext? context}) {
    String tr(String Function(S) key, String fallback) {
      if (context != null) {
        return key(S.of(context));
      }
      return fallback;
    }

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(
              message: tr((s) => s.no_internet, "No Internet Connection"));
        case DioExceptionType.cancel:
          return ApiErrorModel(
              message: tr((s) => s.request_cancelled,
                  "Request to server was canceled"));
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(
              message: tr((s) => s.connection_timeout,
                  "Connection timeout with server"));
        case DioExceptionType.unknown:
          return ApiErrorModel(
              message:
                  "${tr((s) => s.unexpected_error, "Unexpected error:")} ${error.message}");
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
              message:
                  tr((s) => s.receive_timeout, "Receive timeout from server"));
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
              message: tr((s) => s.send_timeout, "Send timeout to server"));
        case DioExceptionType.badCertificate:
          return ApiErrorModel(
              message:
                  tr((s) => s.bad_certificate, "Invalid certificate received"));
        case DioExceptionType.badResponse:
          return _handleBadResponse(
              error.response?.data, error.response?.statusCode, context);
      }
    }
    return ApiErrorModel(message: tr((s) => s.failed, "Operation failed."));
  }

  static ApiErrorModel _handleBadResponse(
      dynamic responseData, int? statusCode, BuildContext? context) {
    String tr(String Function(S) key, String fallback) {
      if (context != null) {
        return key(S.of(context));
      }
      return fallback;
    }

    // ✅ If status code is not 200, handle error
    if (statusCode != 200 && responseData is Map<String, dynamic>) {
      // Check for businessErrorCode first
      if (responseData['businessErrorCode'] != null) {
        final code = responseData['businessErrorCode'] as int?;
        final message = BusinessErrorMapper.getMessage(code);
        return ApiErrorModel(message: message);
      }

      // If no businessErrorCode, try "error" or "message"
      String? errorMessage;
      if (responseData['error'] != null) {
        if (responseData['error'] is String) {
          errorMessage = responseData['error'];
        } else if (responseData['error'] is List &&
            responseData['error'].isNotEmpty) {
          errorMessage = responseData['error'][0];
        }
      }
      errorMessage ??=
          responseData['message'] ?? tr((s) => s.failed, "Operation failed.");
      return ApiErrorModel(message: errorMessage!);
    }

    // Generic HTTP status fallback
    switch (statusCode) {
      case 302:
        return ApiErrorModel(
            message: tr((s) => s.redirection,
                "Redirection occurred. Please login again."));
      case 400:
        return ApiErrorModel(
            message: tr((s) => s.bad_request,
                "Bad request. Please check the data sent."));
      case 401:
        return ApiErrorModel(
            message: tr(
                (s) => s.unauthorized, "Unauthorized. Please log in again."));
      case 403:
        return ApiErrorModel(
            message: tr(
                (s) => s.forbidden, "Forbidden. You do not have permission."));
      case 404:
        return ApiErrorModel(
            message: tr((s) => s.not_found, "Resource not found."));
      case 500:
        return ApiErrorModel(
            message: tr((s) => s.server_error,
                "Server error. Please try again later."));
      default:
        return ApiErrorModel(
            message: tr((s) => s.status_code_error,
                    "Unexpected error with status code {}")
                .replaceFirst("{}", "$statusCode"));
    }
  }
}

class ApiErrorModel {
  final String message;
  ApiErrorModel({required this.message});
}
