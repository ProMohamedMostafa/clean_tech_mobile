import 'package:dio/dio.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(message: 'No Internet Connection');
        case DioExceptionType.cancel:
          return ApiErrorModel(message: 'Request to server was canceled');
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(message: 'Connection timeout with server');
        case DioExceptionType.unknown:
          return ApiErrorModel(message: 'Unexpected error: ${error.message}');
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(message: 'Receive timeout from server');
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(message: 'Send timeout to server');
        case DioExceptionType.badCertificate:
          return ApiErrorModel(message: 'Invalid certificate received');
        case DioExceptionType.badResponse:
          return _handleBadResponse(
              error.response?.data, error.response?.statusCode);
      }
    } else {
      return ApiErrorModel(message: "Unknown error occurred");
    }
  }

  static ApiErrorModel _handleBadResponse(
      dynamic responseData, int? statusCode) {
    if (responseData != null && responseData is Map<String, dynamic>) {
      String? errorMessage;

      // Check for `error` field
      if (responseData['error'] != null) {
        if (responseData['error'] is String) {
          errorMessage = responseData['error'];
        } else if (responseData['error'] is List &&
            responseData['error'].isNotEmpty) {
          errorMessage = responseData['error'][0];
        }
      }

      // Default to `message` field if `error` is null
      errorMessage ??= responseData['message'] ?? 'Unknown error occurred';

      return ApiErrorModel(message: errorMessage!);
    }

    // Handle specific HTTP status codes
    switch (statusCode) {
      case 302:
        return ApiErrorModel(
            message: 'Redirection occurred. Please login again.');
      case 400:
        return ApiErrorModel(
            message: 'Bad request. Please check the data sent.');
      case 401:
        return ApiErrorModel(message: 'Unauthorized. Please log in again.');
      case 403:
        return ApiErrorModel(message: 'Forbidden. You do not have permission.');
      case 404:
        return ApiErrorModel(message: 'Resource not found.');
      case 500:
        return ApiErrorModel(message: 'Server error. Please try again later.');
      case 502:
        return ApiErrorModel(message: 'Bad Gateway. Please try again later.');
      case 503:
        return ApiErrorModel(
            message: 'Service Unavailable. Please try again later.');
      case 504:
        return ApiErrorModel(
            message: 'Gateway Timeout. Please try again later.');
      default:
        return ApiErrorModel(
            message: 'Unexpected error with status code $statusCode');
    }
  }
}

class ApiErrorModel {
  final String message;

  ApiErrorModel({required this.message});
}

// static ApiErrorModel _handleBadResponse(
//       dynamic responseData, int? statusCode) {
//     if (responseData != null && responseData is Map<String, dynamic>) {
//       if (statusCode == 400 && responseData['errors'] != null) {
//         String formattedErrors =
//             _formatValidationErrors(responseData['errors']);
//         return ApiErrorModel(message: formattedErrors);
//       }

//       String errorMessage = responseData['message'] ?? 'Unknown error occurred';
//       return ApiErrorModel(message: errorMessage);
//     }

//     switch (statusCode) {
//       case 302:
//         return ApiErrorModel(
//             message: 'Redirection occurred. Please login again.');
//       case 400:
//         return ApiErrorModel(
//             message: 'Bad request. Please check the data sent.');
//       case 401:
//         return ApiErrorModel(message: 'Unauthorized. Please log in again.');
//       case 403:
//         return ApiErrorModel(message: 'Forbidden. You do not have permission.');
//       case 404:
//         return ApiErrorModel(message: 'Resource not found.');
//       case 500:
//         return ApiErrorModel(message: 'Server error. Please try again later.');
//       case 502:
//         return ApiErrorModel(message: 'Bad Gateway. Please try again later.');
//       case 503:
//         return ApiErrorModel(
//             message: 'Service Unavailable. Please try again later.');
//       case 504:
//         return ApiErrorModel(
//             message: 'Gateway Timeout. Please try again later.');
//       default:
//         return ApiErrorModel(
//             message: 'Unexpected error with status code $statusCode');
//     }
//   }

//   static String _formatValidationErrors(Map<String, dynamic> errors) {
//     for (var messages in errors.values) {
//       if (messages is List && messages.isNotEmpty) {
//         return messages.first.toString(); // Return the first error message.
//       } else if (messages is String) {
//         return messages; // Handle single string error.
//       }
//     }
//     return 'Validation error occurred.'; // Default message if no errors found.
//   }
// }

// class ApiErrorModel {
//   final String message;

//   ApiErrorModel({required this.message});
// }
