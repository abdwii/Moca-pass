import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../debugging/log.dart';
import 'base_response.dart';
import 'constants/methods.dart';
import 'interceptors.dart';

class ApiCaller {
  final String baseUrl;
  final Dio _dio;

  ApiCaller(this.baseUrl)
      : _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10), // Added connect timeout
      receiveTimeout: const Duration(seconds: 10), // Added receive timeout
    ),
  )..interceptors.add(LoggingInterceptor());

  Future<Either<String, BaseResponse>> call({
    required String endpoint,
    required APIMethods method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    // Removed _dio initialization from here. It's now in the constructor.
    try {
      // Use a local variable for options to avoid modifying the input parameter
      final requestOptions = options ?? Options();
      requestOptions.method = method.name;

      final response = await _dio.request(
        endpoint,
        data: data,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: requestOptions,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
      );

      Log.debug(
          "url : ${response.realUri}\n=====\nheaders : \n${response.headers}\n=====\nresponse : ${response.data}"); // Changed to response.data

      // Check for HTTP status codes and handle errors
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        // Success
        return Right(BaseResponse.fromJson(response.data)); // Changed to response.data
      } else {
        // Handle non-2xx status codes as errors
        return Left(
            _handleErrorResponse(response)); // Use a helper function to handle error responses
      }
    } on DioException catch (error) {
      Logger().e(error.message);
      return Left(_handleDioError(error)); // Use a helper function to handle Dio errors
    } on SocketException {
      Log.error("connection error");
      return const Left('connection error');
    } catch (e) {
      Log.error("error: $e"); // Added the error to the log
      return const Left('An unexpected error occurred.'); // More descriptive error message
    }
  }

  // Helper function to handle Dio errors
  String _handleDioError(DioException error) {
    if (error.response != null) {
      return _handleErrorResponse(error.response!);
    } else if (error.type == DioExceptionType.connectionTimeout) {
      return 'Connection timed out.';
    } else if (error.type == DioExceptionType.sendTimeout) {
      return 'Send timed out.';
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return 'Receive timed out.';
    } else if (error.type == DioExceptionType.connectionError) {
      return 'Connection error.';
    } else {
      return error.message ?? 'An unknown error occurred.';
    }
  }

  // Helper function to handle error responses
  String _handleErrorResponse(Response response) {
    try {
      if (response.data != null) {
        final baseResponse = BaseResponse.fromJson(response.data);
        return baseResponse.message ?? 'An error occurred.';
      } else {
        return 'An error occurred with no response data.';
      }
    } catch (e) {
      return 'Failed to parse error response.';
    }
  }
}