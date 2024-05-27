import 'package:dio/dio.dart';
import '../debugging/log.dart';
import '../failure/failure.dart';
import '../failure/network_failures/network_failures.dart';
import '../failure/unknown_failure.dart';
import 'constants/status_codes.dart';

abstract class APICallerErrorHandler {
  static Failure handle(DioException error) {
    if (error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      Log.error("timeout error");
      return TimeoutFailure();
    } else if (error.type == DioExceptionType.cancel) {
      Log.error("cancel error");
      return CancelFailure();
    } else if (error.type == DioExceptionType.badResponse) {
      return _responseErrorHandler(error.response!);
    } else {
      Log.error(error);
      return UnknownFailure();
    }
  }

  static Failure _responseErrorHandler(Response response) {
    Log.error(
        "url : ${response.realUri}\n=====\nheaders : \n${response.headers}\n=====\nresponse : $response");
    if (response.statusCode == StatusCodes.notFound) {
      Log.error("not found error");
      return NotFoundFailure();
    } else if (response.statusCode == StatusCodes.forbidden) {
      Log.error("forbidden error");
      return ForbiddenFailure();
    } else if (response.statusCode == StatusCodes.internalServerError) {
      Log.error("internal server error");
      return InternalServerErrorFailure();
    } else if (response.statusCode == StatusCodes.timeout) {
      Log.error("timeout error");
      return TimeoutFailure();
    } else if (response.statusCode == StatusCodes.unauthorized) {
      Log.error("unauthorized error");
      return UnauthorizedFailure();
    } else {
      Log.error(
          "error code : ${response.statusCode}\nerror message : ${response.statusMessage}");
      return UnknownFailure();
    }
  }
}
