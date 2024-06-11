import 'package:MocaPass/core/api/app_configs/app_config.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/api/api_caller.dart';
import '../../../core/api/constants/endpoints.dart';
import '../../../core/api/constants/methods.dart';
import '../../../core/local_data/session_management.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit() : super(ScanInitial());

  Future<void> scanIn() async {
    emit(ScanLoading());
    final call = await APICaller(AppConfig.baseUrl).call(
      endpoint: Endpoints.scanIn,
      method: APIMethods.post,
      options: Options(headers: {
        "Authorization": "Bearer ${SessionManagement.getUserToken()}"
      }),
    );

    call.fold(
      (error) => emit(ScanError(error)),
      (response) {

      },
    );
  }
}
