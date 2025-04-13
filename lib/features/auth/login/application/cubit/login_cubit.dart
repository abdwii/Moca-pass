import 'package:MocaPass/core/api/app_configs/app_config.dart';
import 'package:MocaPass/features/auth/login/model/login_pojo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/api/api_caller.dart';
import '../../../../../core/api/constants/endpoints.dart';
import '../../../../../core/api/constants/methods.dart';
import '../../../../../core/local_data/session_management.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  String email = "";
  String password = "";

  LoginCubit() : super(LoginStateInitial());

  final APICaller _apiCaller = APICaller(AppConfig.authBaseUrl);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> signIn(BuildContext context) async {
    emit(LoginStateLoading());
    final call = await _apiCaller.call(
      endpoint: Endpoints.login,
      method: APIMethods.post,
      data: {
        'email': email,
        'password': password,
      },
    );
    call.fold(
      (failure) {
        emit(LoginStateError(message: failure.toString()));
      },
      (response) {
        if (response.succeeded == true) {
          LoginPojo loginModel = LoginPojo.fromJson(response.data as Map<String, dynamic>);
          SessionManagement.createSession(token: loginModel.jwToken ?? "");
          emit(LoginStateLoaded());
        } else {
          emit(LoginStateError(message: response.errors.toString()));
        }
      },
    );
    // }
  }

  bool isValidPassword(String password) {
    return password.isNotEmpty && password.length >= 8 ? true : false;
  }

  bool isValidEmail(String? email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (email == null) {
      return this.email.isNotEmpty && emailRegex.hasMatch(this.email)
          ? true
          : false;
    } else {
      return email.isNotEmpty && emailRegex.hasMatch(email) ? true : false;
    }
  }

  bool isValidForm(String email, String password) {
    return isValidEmail(email) && isValidPassword(password);
  }
}
