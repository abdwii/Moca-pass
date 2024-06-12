import 'dart:convert';
import 'dart:io';

import 'package:MocaPass/core/api/app_configs/app_config.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../core/api/api_caller.dart';
import '../../../core/api/base_response.dart';
import '../../../core/api/constants/endpoints.dart';
import '../../../core/api/constants/methods.dart';
import '../../../core/local_data/session_management.dart';
import '../../auth/login/model/login_pojo.dart';
import '../model/qr_code_scan_request.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit() : super(ScanInitial());

  Future<void> scanIn(String qrCode) async {
    emit(ScanLoading());
    final call = await APICaller(AppConfig.baseUrl).call(
      endpoint: Endpoints.scanIn,
      method: APIMethods.post,
      options: Options(
        headers: {"Authorization": "Bearer ${SessionManagement.getUserToken()}"},
      ),
      data: QrCodeScanRequest(hashQrCode: qrCode).toJson(),
    );

    call.fold(
      (error) async {

        try {
          if (int.parse(error) == 401) {
            await refreshToken();
            emit(ScanLoaded(true));
          } else {
            emit(ScanError("Try again."));
          }
        } catch (e) {
          emit(ScanError(error));
        }
      },
      (response) {
        if (response.succeeded == true) {
          response.data
              ? emit(ScanLoaded(true))
              : emit(ScanError(response.errors?[0] ?? "Something wrong!!"));
        } else {
          emit(ScanError(response.errors.toString()));
        }
      },
    );
  }

  Future<Either<String, BaseResponse>?> refreshToken() async {
    try {
      Options options = Options(
        method: "POST",
      );
      if (options.headers?['requires-token'] == 'false') {
        options.headers?.remove('requiresToken');
      }
      final call = await APICaller(AppConfig.authBaseUrl).call(
        endpoint: Endpoints.refreshToken,
        method: APIMethods.post,
        queryParameters: {"ExpiredToken": SessionManagement.getUserToken()},
      );
      call.fold((error) => {Left(error.toString())}, (response) {
        Logger().w(
            "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHRefreshed Token ${decodeNewTokenFromJson(response)}");
        SessionManagement.setStringValue(
            SessionManagement.TOKEN_KEY, decodeNewTokenFromJson(response));
      });
    } on SocketException {
      return const Left('connection error');
    } catch (e) {
      return const Left('error');
    }
  }

  String decodeNewTokenFromJson(BaseResponse response) {
    return LoginPojo.fromJson(jsonDecode(
            BaseResponse.fromJson(jsonDecode(response.toString()))
                .data
                .toString()))
        .jwToken!;
  }
}
