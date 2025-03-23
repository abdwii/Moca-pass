import 'package:MocaPass/core/api/api_caller.dart';
import 'package:MocaPass/core/api/app_configs/app_config.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/api/constants/endpoints.dart';
import '../../../core/api/constants/methods.dart';
import '../../../core/local_data/session_management.dart';
import '../model/qr_code_scan_request.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit() : super(ScanInitial());
  bool? isScanIn;
  Future<void> scanIn(String qrCode) async {
    emit(ScanLoading());
    final call = await ApiCaller(AppConfig.baseUrl).call(
      endpoint: Endpoints.scanIn,
      method: APIMethods.post,
      options: Options(
        headers: {
          "Authorization": "Bearer ${SessionManagement.getUserToken()}"
        },
      ),
      data: QrCodeScanRequest(hashQrCode: qrCode).toJson(),
    );

    call.fold(
      (error) async {
        emit(ScanError(error));
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

  Future<void> scanOut(String qrCode) async {
    emit(ScanLoading());
    final call = await ApiCaller(AppConfig.baseUrl).call(
      endpoint: Endpoints.scanOut,
      method: APIMethods.post,
      options: Options(
        headers: {
          "Authorization": "Bearer ${SessionManagement.getUserToken()}"
        },
      ),
      data: QrCodeScanRequest(hashQrCode: qrCode).toJson(),
    );

    call.fold(
      (error) async {
        emit(ScanError(error));
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
