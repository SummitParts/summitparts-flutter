import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:summit_parts/core/exception_handling/exceptions/app_exception.dart';

class ErrorFormatter {
  ErrorFormatter._();

  static String format(Exception exception) {
    if (exception is AppException) {
      return exception.message;
    }

    if (exception is SocketException || (exception is DioException && exception.error is SocketException)) {
      return 'Please check your internet connection';
    }

    if (exception is DioException) {
      return exception.response?.data['message'] ??
          exception.message ??
          exception.error.toString() ??
          exception.toString();
    }

    if (exception is PlatformException) {
      return exception.message ?? exception.code;
    }

    return 'Unexpected $exception';
  }
}
