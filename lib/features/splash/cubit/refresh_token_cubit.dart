import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../core/api/api_caller.dart';
import '../../../core/api/app_configs/app_config.dart';
import '../../../core/api/constants/endpoints.dart';
import '../../../core/api/constants/methods.dart';
import '../../../core/local_data/session_management.dart';
import '../../auth/login/model/login_pojo.dart';
// import 'package:meta/meta.dart';

part 'refresh_token_state.dart';

class RefreshTokenCubit extends Cubit<RefreshTokenState> {
  RefreshTokenCubit() : super(RefreshTokenInitial());

  Future<void> refreshToken() async {
    emit(RefreshTokenLoading());
    final call = await ApiCaller(AppConfig.authBaseUrl).call(
      endpoint: Endpoints.refreshToken,
      method: APIMethods.post,
      queryParameters: {"ExpiredToken": SessionManagement.getUserToken()},
    );
    call.fold((error) => {emit(RefreshTokenError())}, (response) {
      if (response.succeeded == true) {
        LoginPojo loginModel = LoginPojo.fromJson(response.data);
        emit(RefreshTokenLoaded());
        Logger().w("HHHRefreshed Token ${loginModel.jwToken}");
        SessionManagement.setStringValue(
            SessionManagement.TOKEN_KEY, loginModel.jwToken!);
      } else {
        emit(RefreshTokenError());
      }
    });
  }
}
