import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../debugging/log.dart';
import 'interceptors.dart';

import 'base_response.dart';
import 'constants/api_caller_config.dart';
import 'constants/methods.dart';

class APICaller {
  APICaller._();

  static final APICaller instance = APICaller._();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: APICallerConfiguration.baseUrl,
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
      options = options ?? Options();
      options.method = method.name;
      Response response = await _dio.request(
        endpoint,
        data: data,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: options,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
      );
      Log.debug(
          "url : ${response.realUri}\n=====\nheaders : \n${response.headers}\n=====\nresponse : $response");

      return Right(BaseResponse.fromJson(jsonDecode(response.toString())));
    } on DioException catch (error) {
      Log.error(error.message);
      return Left(BaseResponse.fromJson(jsonDecode(error.response.toString()))
              .message ??
          error.response.toString());
    } on SocketException {
      Log.error("connection error");
      return const Left('connection error');
    } catch (e) {
      Log.error("error");
      return const Left('error');
    }
  }
}
