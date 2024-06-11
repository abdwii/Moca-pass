import 'dart:ffi';

import 'package:MocaPass/core/api/app_configs/app_config.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/api/api_caller.dart';
import '../../../core/api/constants/endpoints.dart';
import '../../../core/api/constants/methods.dart';
import '../../../core/local_data/session_management.dart';
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
        headers: {
          "Authorization": "${SessionManagement.getUserToken()}"
        },
      ),
      data: QrCodeScanRequest(hashQrCode: qrCode).toJson(),
    );

    call.fold(
      (error) {
        try {
          if (int.parse(error) == 401) {
            //refresh token
          }
          emit(ScanError("Try again."));
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
}
