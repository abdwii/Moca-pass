import 'package:dio/dio.dart';

import '../debugging/log.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept'] = 'application/json';
    super.onRequest(options, handler);
  }
}

///Log interceptor settings
class LoggingInterceptor extends Interceptor {
  DateTime? startTime;
  DateTime? endTime;

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    startTime = DateTime.now();
    Log.debug('----------Request Start---------');
    Log.info(' path :${options.path}');

    ///print full path request
    if (options.queryParameters.isEmpty) {
      if (options.path.contains(options.baseUrl)) {
        Log.info('RequestUrl:${options.path}');
      } else {
        Log.info('RequestUrl:${options.baseUrl}${options.path}');
      }
    } else {
      ///If queryParameters is not empty, splice into a complete URl
      Log.info(
        "RequestUrl:${options.baseUrl}${options.path}?${Transformer.urlEncodeMap(options.queryParameters)}",
      );
    }

    Log.warning('RequestMethod:${options.method}');
    Log.warning('RequestHeaders:${options.headers}');
    Log.warning('RequestContentType:${options.contentType}');
    Log.warning(
      'RequestDataOptions:${options.data is FormData ? (options.data as FormData).fields.toString() + (options.data as FormData).files.toString() : options.data.toString()}',
    );

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    endTime = DateTime.now();
    //Request duration
    int duration = endTime!.difference(startTime!).inMilliseconds;
    Log.info(
      '----------Response code ${response.statusCode} Data $response --------- Url ${response.realUri.path} ---------',
    );
    Log.info('----------End Request $duration millisecond---------');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Log.error('--------------Error-----------');
    Log.error('${err.message.toString()}${err.stackTrace.toString()}');
    super.onError(err, handler);
  }
}
