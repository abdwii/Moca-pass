import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

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
            connectTimeout:
                const Duration(seconds: 10), // Added connect timeout
            receiveTimeout:
                const Duration(seconds: 10), // Added receive timeout
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
    try {
      // Use a local variable for options to avoid modifying the original if it's passed.
      Options requestOptions = options ?? Options();
      requestOptions.method = method.name;

      Response response = await _dio.request(
        endpoint,
        data: data,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: requestOptions,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
      );

      // Improved logging
      Log.debug("Request URL: ${response.realUri}\n"
          "Request Headers: ${response.requestOptions.headers}\n"
          "Response Status: ${response.statusCode}\n"
          "Response Headers: ${response.headers}\n"
          "Response Data: ${response.data}");

      // Handle non-2xx status codes
      if (response.statusCode != null &&
          (response.statusCode! < 200 || response.statusCode! >= 300)) {
        return Left(_handleErrorResponse(response));
      }

      return Right(BaseResponse.fromJson(response.data));
    } on DioException catch (error) {
      Log.error("Dio Error: ${error.message}");
      return Left(_handleDioError(error));
    } on SocketException {
      Log.error("Socket Exception: Connection error");
      return const Left('Connection error');
    } catch (e) {
      Log.error("Unexpected Error: $e");
      return const Left('Unexpected error');
    }
  }

  // Helper function to handle Dio errors
  String _handleDioError(DioException error) {
    if (error.response != null) {
      return _handleErrorResponse(error.response!);
    } else {
      return error.message ?? 'Unknown Dio error';
    }
  }

  // Helper function to handle error responses
  String _handleErrorResponse(Response response) {
    try {
      // Try to parse the error response as a BaseResponse
      final baseResponse = BaseResponse.fromJson(response.data);
      return baseResponse.message ?? 'Error: ${response.statusCode}';
    } catch (e) {
      // If parsing fails, return a generic error message
      return 'Error: ${response.statusCode} - ${response.data}';
    }
  }
}
